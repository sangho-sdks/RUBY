# frozen_string_literal: true

module Sangho
  module Resources
    class Receipts < BaseResource

      def list(**c)   ; @http.assert_secret_key!("receipts.list")   ; @http.get("/receipts/", c) ; end
      def retrieve(id); @http.assert_secret_key!("receipts.retrieve"); @http.get("/receipts/#{id}/") ; end
      def send(id, email: nil); @http.assert_secret_key!("receipts.send"); @http.post("/receipts/#{id}/send/", email ? {email: email} : {}); end
      def options; @http.options("/receipts/"); end

    end
  end
end
