# frozen_string_literal: true

module Sangho
  module Resources
    class PaymentLinks < BaseResource

      def list(**c)   ; @http.assert_secret_key!("payment_links.list")   ; @http.get("/payment-links/", c) ; end
      def retrieve(id); @http.assert_secret_key!("payment_links.retrieve"); @http.get("/payment-links/#{id}/") ; end
      def create(amount:, **o); @http.assert_secret_key!("payment_links.create"); @http.post("/payment-links/", {amount: amount}.merge(o)); end
      def update(id, **p)  ; @http.assert_secret_key!("payment_links.update")    ; @http.patch("/payment-links/#{id}/", p); end
      def deactivate(id)   ; @http.assert_secret_key!("payment_links.deactivate"); @http.post("/payment-links/#{id}/deactivate/"); end
      def options; @http.options("/payment-links/"); end

    end
  end
end
