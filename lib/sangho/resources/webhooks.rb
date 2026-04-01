# frozen_string_literal: true

module Sangho
  module Resources
    # Provides access to webhook resources and operations.
    class Webhooks < BaseResource
      def list(**c)
        @http.assert_secret_key!('webhooks.list')
        @http.get('/webhooks/', c)
      end

      def retrieve(id)
        @http.assert_secret_key!('webhooks.retrieve')
        @http.get("/webhooks/#{id}/")
      end

      def create(url:, events:, **o)
        @http.assert_secret_key!('webhooks.create')
        @http.post('/webhooks/', { url: url, events: events }.merge(o))
      end

      def update(id, **p)
        @http.assert_secret_key!('webhooks.update')
        @http.patch("/webhooks/#{id}/", p)
      end

      def delete(id)
        @http.assert_secret_key!('webhooks.delete')
        @http.delete("/webhooks/#{id}/")
      end

      def roll_secret(id)
        @http.assert_secret_key!('webhooks.roll_secret')
        @http.post("/webhooks/#{id}/roll-secret/")
      end

      def send_test_event(id, type)
        @http.assert_secret_key!('webhooks.send_test_event')
        @http.post("/webhooks/#{id}/test/", { event_type: type })
      end

      def list_deliveries(id, **c)
        @http.assert_secret_key!('webhooks.list_deliveries')
        @http.get("/webhooks/#{id}/deliveries/", c)
      end

      def retry_delivery(id, did)
        @http.assert_secret_key!('webhooks.retry_delivery')
        @http.post("/webhooks/#{id}/deliveries/#{did}/retry/")
      end

      def options = @http.options('/webhooks/')

      def self.construct_event(payload, sig_header, secret, tolerance: 300)
        require 'openssl'
        require 'json'
        parts = parse_signature_header(sig_header)
        validate_signature_header(parts, tolerance)
        validate_signature(payload, parts, secret)
        JSON.parse(payload, symbolize_names: true)
      end


      def self.parse_signature_header(sig_header)
        sig_header.split(',').each_with_object({}) do |p, h|
          k, v = p.split('=', 2)
          h[k] = v
        end
      end

      def self.validate_signature_header(parts, tolerance)
        ts = parts['t']
        v1 = parts['v1']
        raise SanghoError.new('Invalid header.', code: 'invalid_signature') unless ts && v1
        raise SanghoError.new('Timestamp too old.', code: 'stale_event') if (Time.now.to_i - ts.to_i).abs > tolerance
      end

      def self.validate_signature(payload, parts, secret)
        expected = OpenSSL::HMAC.hexdigest('SHA256', secret, "#{parts['t']}.#{payload}")
        raise SanghoError.new('Signature mismatch.', code: 'invalid_signature') unless expected == parts['v1']
      end
    end
  end
end
