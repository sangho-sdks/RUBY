# frozen_string_literal: true

module Sangho
  module Resources
    # Provides access to the Checkout Sessions API resource.
    class CheckoutSessions < BaseResource
      def list(**c)
        @http.assert_secret_key!('checkout_sessions.list')
        @http.get('/checkout-sessions/', c)
      end

      def retrieve(id)
        @http.assert_secret_key!('checkout_sessions.retrieve'); 
        @http.get("/checkout-sessions/#{id}/")
      end

      def create(amount:, success_url:, cancel_url:, **o)
        @http.assert_secret_key!('checkout_sessions.create')
        @http.post('/checkout-sessions/', {amount: amount, success_url: success_url, cancel_url: cancel_url}.merge(o))
      end

      def expire(id)
        @http.assert_secret_key!('checkout_sessions.expire')
        @http.post("/checkout-sessions/#{id}/expire/")
      end

      def options = @http.options('/checkout-sessions/')
    end
  end
end
