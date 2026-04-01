# frozen_string_literal: true

module Sangho
  module Resources
    # Provides access to the Apps API resource.
    class Apps < BaseResource
      def list(**opts)
        @http.assert_secret_key!('apps.list')
        @http.get('/apps/', opts)
      end

      def retrieve(id)
        @http.assert_secret_key!('apps.retrieve')
        @http.get("/apps/#{id}/")
      end

      def create(name:, **opts)
        @http.assert_secret_key!('apps.create')
        @http.post('/apps/', { name: name }.merge(opts))
      end

      def update(id, **params)
        @http.assert_secret_key!('apps.update')
        @http.patch("/apps/#{id}/", params)
      end

      def delete(id)
        @http.assert_secret_key!('apps.delete')
        @http.delete("/apps/#{id}/")
      end

      def roll_secret(id)
        @http.assert_secret_key!('apps.roll_secret')
        @http.post("/apps/#{id}/roll-secret/")
      end

      def options = @http.options('/apps/')
    end
  end
end
