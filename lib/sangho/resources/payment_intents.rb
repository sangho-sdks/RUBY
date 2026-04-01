# frozen_string_literal: true

module Sangho
  module Resources
    class PaymentIntents < BaseResource

      def list(**c)   ; @http.assert_secret_key!("payment_intents.list")   ; @http.get("/payment-intents/", c) ; end
      def retrieve(id); @http.assert_secret_key!("payment_intents.retrieve"); @http.get("/payment-intents/#{id}/") ; end
      def create(amount:, customer:, **o); @http.assert_secret_key!("payment_intents.create"); @http.post("/payment-intents/", {amount: amount, customer: customer}.merge(o)); end
      def update(id, **p); @http.assert_secret_key!("payment_intents.update"); @http.patch("/payment-intents/#{id}/", p); end
      def confirm(id, **p); @http.assert_secret_key!("payment_intents.confirm"); @http.post("/payment-intents/#{id}/confirm/", p); end
      def capture(id, **p); @http.assert_secret_key!("payment_intents.capture"); @http.post("/payment-intents/#{id}/capture/", p); end
      def cancel(id, **p) ; @http.assert_secret_key!("payment_intents.cancel") ; @http.post("/payment-intents/#{id}/cancel/", p); end
      def options; @http.options("/payment-intents/"); end

    end
  end
end
