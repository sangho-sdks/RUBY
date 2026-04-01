# frozen_string_literal: true

module Sangho
  module Resources
    class Invoices < BaseResource

      def list(**c)   ; @http.assert_secret_key!("invoices.list")   ; @http.get("/invoices/", c) ; end
      def retrieve(id); @http.assert_secret_key!("invoices.retrieve"); @http.get("/invoices/#{id}/") ; end
      def create(customer:, **o); @http.assert_secret_key!("invoices.create"); @http.post("/invoices/", {customer: customer}.merge(o)); end
      def update(id, **p); @http.assert_secret_key!("invoices.update"); @http.patch("/invoices/#{id}/", p); end
      def delete(id)     ; @http.assert_secret_key!("invoices.delete"); @http.delete("/invoices/#{id}/"); end
      def pay(id, **p)   ; @http.assert_secret_key!("invoices.pay")   ; @http.post("/invoices/#{id}/pay/", p); end
      def finalize(id)   ; @http.assert_secret_key!("invoices.finalize"); @http.post("/invoices/#{id}/finalize/"); end
      def void(id)       ; @http.assert_secret_key!("invoices.void")    ; @http.post("/invoices/#{id}/void/"); end
      def mark_uncollectible(id); @http.assert_secret_key!("invoices.mark_uncollectible"); @http.post("/invoices/#{id}/mark-uncollectible/"); end
      def send_invoice(id)      ; @http.assert_secret_key!("invoices.send_invoice")      ; @http.post("/invoices/#{id}/send/"); end
      def options; @http.options("/invoices/"); end

    end
  end
end
