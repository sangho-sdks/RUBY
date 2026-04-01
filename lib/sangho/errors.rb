# frozen_string_literal: true

module Sangho
  # Base error class for all Sangho API errors
  class SanghoError < StandardError
    attr_reader :code, :status_code, :raw

    def initialize(msg = nil, code: 'api_error', status_code: nil, raw: {})
      super(msg)
      @code        = code
      @status_code = status_code
      @raw         = raw || {}
    end
  end

  class SanghoAuthError        < SanghoError; end
  class SanghoPublicKeyError   < SanghoError; end
  class SanghoPermissionError  < SanghoError; end
  class SanghoNotFoundError    < SanghoError; end
  class SanghoIdempotencyError < SanghoError; end

  # Raised when API rate limit is exceeded
  class SanghoRateLimitError < SanghoError
    attr_reader :retry_after

    def initialize(retry_after: 60)
      @retry_after = retry_after
      super("Rate limit exceeded. Retry after #{retry_after}s.",
            code: 'rate_limit_exceeded', status_code: 429)
    end
  end

  # Raised when API response validation fails
  class SanghoValidationError < SanghoError
    def field_errors
      errors = raw[:detail] || raw[:errors] || {}
      errors.is_a?(Hash) ? errors : {}
    end
  end
end
