# frozen_string_literal: true

module Sangho
  module Resources
    class Products < BaseResource

      def list(**c)   ; @http.assert_secret_key!("products.list")   ; @http.get("/products/", c) ; end
      def retrieve(id); @http.assert_secret_key!("products.retrieve"); @http.get("/products/#{id}/") ; end
      def create(name:, price:, **o); @http.assert_secret_key!("products.create"); @http.post("/products/", {name: name, price: price}.merge(o)); end
      def update(id, **p); @http.assert_secret_key!("products.update"); @http.patch("/products/#{id}/", p); end
      def delete(id)     ; @http.assert_secret_key!("products.delete"); @http.delete("/products/#{id}/"); end
      def archive(id)    ; @http.assert_secret_key!("products.archive"); @http.post("/products/#{id}/archive/"); end
      def restore(id)    ; @http.assert_secret_key!("products.restore"); @http.post("/products/#{id}/restore/"); end
      def options; @http.options("/products/"); end

    end
  end
end
