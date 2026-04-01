# frozen_string_literal: true

module Sangho
  module Resources
    class PaymentMethods < BaseResource

      def list(**c)   ; @http.assert_secret_key!("payment_methods.list")   ; @http.get("/payment-methods/", c) ; end
      def retrieve(id); @http.assert_secret_key!("payment_methods.retrieve"); @http.get("/payment-methods/#{id}/") ; end
      def create(type:, **o); @http.assert_secret_key!("payment_methods.create"); @http.post("/payment-methods/", {type: type}.merge(o)); end
      def update(id, **p)  ; @http.assert_secret_key!("payment_methods.update")    ; @http.patch("/payment-methods/#{id}/", p); end
      def delete(id)       ; @http.assert_secret_key!("payment_methods.delete")    ; @http.delete("/payment-methods/#{id}/"); end
      def set_default(id)  ; @http.assert_secret_key!("payment_methods.set_default"); @http.post("/payment-methods/#{id}/set-default/"); end
      def attach(id, customer:); @http.assert_secret_key!("payment_methods.attach"); @http.post("/payment-methods/#{id}/attach/", {customer: customer}); end
      def detach(id)       ; @http.assert_secret_key!("payment_methods.detach")    ; @http.post("/payment-methods/#{id}/detach/"); end
      def options; @http.options("/payment-methods/"); end

    end
  end
end
