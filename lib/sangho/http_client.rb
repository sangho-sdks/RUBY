# frozen_string_literal: true

require 'faraday'
require 'json'
require 'securerandom'

module Sangho
  # HTTP client for making requests to the Sangho API.
  class HttpClient
    VALID_PREFIXES  = %w[pk_live_ sk_live_ pk_test_ sk_test_].freeze
    RETRY_DELAYS    = [0.5, 1.0, 2.0].freeze
    RETRYABLE_CODES = [429, 500, 502, 503, 504].freeze

    attr_reader :key_type

    def initialize(api_key:, base_url: 'https://api.sangho.com/v1', timeout: 30)
      raise ArgumentError, 'Invalid API key format.' unless VALID_PREFIXES.any? { |p| api_key.start_with?(p) }

      @key_type = api_key.start_with?('pk_') ? :public : :secret
      @conn = build_connection(api_key, base_url, timeout)
    end

    def assert_secret_key!(method)
      return unless @key_type == :public

      raise SanghoPublicKeyError.new(
        "Method `#{method}` requires a secret key.",
        code: 'public_key_not_allowed', status_code: 403
      )
    end

    def get(path, params = {})
      request(:get, path, params: params.compact)
    end

    def post(path, body = {})
      request(:post, path, body: body, extra_headers: { 'Idempotency-Key' => SecureRandom.uuid })
    end

    def patch(path, body)
      request(:patch, path, body: body)
    end

    def delete(path)
      request(:delete, path)
      nil
    end

    def options(path)
      request(:options, path)
    end

    private

    def build_connection(api_key, base_url, timeout)
      Faraday.new(url: base_url) do |f|
        f.headers['Authorization'] = "Bearer #{api_key}"
        f.headers['Content-Type']  = 'application/json'
        f.headers['Accept']        = 'application/json'
        f.headers['User-Agent']    = 'sangho-ruby/1.0.0'
        f.options.timeout          = timeout
        f.adapter Faraday.default_adapter
      end
    end

    def request(method, path, params: {}, body: nil, extra_headers: {})
      RETRY_DELAYS.each do |delay|
        resp = run(method, path, params, body, extra_headers)
        return handle(resp) unless RETRYABLE_CODES.include?(resp.status)

        sleep delay
      end
      handle(run(method, path, params, body, extra_headers))
    end

    def run(method, path, params, body, extra_headers)
      @conn.run_request(method, path, body&.to_json, extra_headers) do |req|
        req.params.merge!(params) if params.any?
      end
    end

    def handle(resp)
      return nil if resp.status == 204

      data = begin
        JSON.parse(resp.body, symbolize_names: true)
      rescue StandardError
        {}
      end
      return data if resp.success?

      raise_error(resp.status, data)
    end

    def raise_error(status, data)
      msg = error_message(data)
      code = data[:code]&.to_s
      error = build_error(status, msg, code, data)
      raise error
    end

    def error_message(data)
      (data[:message] || data[:detail] || 'API error').to_s
    end

    def build_error(status, msg, code, data)
      error_map = {
        401 => -> { SanghoAuthError.new(msg, status_code: 401, raw: data) },
        403 => -> { build_403_error(msg, code, data) },
        404 => -> { SanghoNotFoundError.new(msg, status_code: 404, raw: data) },
        409 => -> { SanghoIdempotencyError.new(msg, status_code: 409, raw: data) },
        422 => -> { SanghoValidationError.new(msg, status_code: 422, raw: data) },
        429 => -> { SanghoRateLimitError.new(retry_after: data[:retry_later] || 60) }
      }
      error_map[status]&.call || SanghoError.new(msg, status_code: status, raw: data)
    end

    def build_403_error(msg, code, data)
      if code == 'public_key_not_allowed'
        SanghoPublicKeyError.new(msg, code: code, status_code: 403, raw: data)
      else
        SanghoPermissionError.new(msg, status_code: 403, raw: data)
      end
    end
  end
end
