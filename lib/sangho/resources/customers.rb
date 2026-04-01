# frozen_string_literal: true

module Sangho
  module Resources
    class Customers < BaseResource

      def list(**c)   ; 
        @http.assert_secret_key!('customers.list') 
        @http.get('/customers/', c)
      end

      def retrieve(id) 
        @http.assert_secret_key!('customers.retrieve') 
        @http.get("/customers/#{id}/")
      end

      def create(email:, name:, **o); 
        @http.assert_secret_key!("customers.create"); 
        @http.post("/customers/", {email: email, name: name}.merge(o)); 
      end

      def update(id, **p); 
        @http.assert_secret_key!("customers.update"); 
        @http.patch("/customers/#{id}/", p); 
      end

      def delete(id)     ; 
        @http.assert_secret_key!("customers.delete"); 
        @http.delete("/customers/#{id}/"); 
      end

      def list_transactions(id, **c); 
        @http.assert_secret_key!("customers.list_transactions"); 
        @http.get("/customers/#{id}/transactions/", c); 
      end

      def options() = @http.options("/customers/")

    end
  end
end
