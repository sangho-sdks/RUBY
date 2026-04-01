# frozen_string_literal: true

module Sangho
  module Resources
    class Transactions < BaseResource

      def list(**c)   ; @http.assert_secret_key!("transactions.list")   ; @http.get("/transactions/", c) ; end
      def retrieve(id); @http.assert_secret_key!("transactions.retrieve"); @http.get("/transactions/#{id}/") ; end
      def options; @http.options("/transactions/"); end

    end
  end
end
