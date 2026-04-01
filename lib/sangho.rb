# frozen_string_literal: true

require_relative 'sangho/errors'
require_relative 'sangho/client'

# Sangho SDK for Ruby
module Sangho
  @api_key  = nil
  @base_url = 'https://api.sangho.com/v1'
  @timeout  = 30

  class << self
    attr_accessor :api_key, :base_url, :timeout

    # Block-style configuration:
    #   Sangho.configure { |c| c.api_key = "sk_test_xxx" }
    def configure
      yield self
    end

    # Convenience: Sangho.new("sk_test_xxx")
    def new(api_key, base_url: @base_url, timeout: @timeout)
      SanghoClient.new(api_key: api_key, base_url: base_url, timeout: timeout)
    end
  end
end
