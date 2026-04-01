# frozen_string_literal: true

module Sangho
  module Resources
    class Security < BaseResource

      def retrieve; @http.assert_secret_key!("security.retrieve"); @http.get("/security/"); end
      def update(**p); @http.assert_secret_key!("security.update"); @http.patch("/security/", p); end
      def roll_secret_key; @http.assert_secret_key!("security.roll_secret_key"); @http.post("/security/roll-secret/"); end
      def list_sessions(**c); @http.assert_secret_key!("security.list_sessions"); @http.get("/security/sessions/", c); end
      def revoke_session(id); @http.assert_secret_key!("security.revoke_session"); @http.delete("/security/sessions/#{id}/"); end
      def options; @http.options("/security/"); end

    end
  end
end
