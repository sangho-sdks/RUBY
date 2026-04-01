# frozen_string_literal: true

module Sangho
  module Resources
    class Partners < BaseResource

      def list(**c)   ; @http.assert_secret_key!("partners.list")   ; @http.get("/partners/", c) ; end
      def retrieve(id); @http.assert_secret_key!("partners.retrieve"); @http.get("/partners/#{id}/") ; end
      def create(name:, **o); @http.assert_secret_key!("partners.create"); @http.post("/partners/", {name: name}.merge(o)); end
      def update(id, **p); @http.assert_secret_key!("partners.update"); @http.patch("/partners/#{id}/", p); end
      def delete(id)     ; @http.assert_secret_key!("partners.delete"); @http.delete("/partners/#{id}/"); end
      def options; @http.options("/partners/"); end

    end
  end
end
