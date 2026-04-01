# frozen_string_literal: true

module Sangho
  module Resources
    class Refunds < BaseResource

      def list(**c)   ; @http.assert_secret_key!("refunds.list")   ; @http.get("/refunds/", c) ; end
      def retrieve(id); @http.assert_secret_key!("refunds.retrieve"); @http.get("/refunds/#{id}/") ; end
      def create(transaction:, **o); @http.assert_secret_key!("refunds.create"); @http.post("/refunds/", {transaction: transaction}.merge(o)); end
      def update(id, **p); @http.assert_secret_key!("refunds.update"); @http.patch("/refunds/#{id}/", p); end
      def cancel(id)     ; @http.assert_secret_key!("refunds.cancel"); @http.post("/refunds/#{id}/cancel/"); end
      def options; @http.options("/refunds/"); end

    end
  end
end
