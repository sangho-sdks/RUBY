# frozen_string_literal: true

module Sangho
  module Resources
    class Subscriptions < BaseResource

      def list(**c)   ; @http.assert_secret_key!("subscriptions.list")   ; @http.get("/subscriptions/", c) ; end
      def retrieve(id); @http.assert_secret_key!("subscriptions.retrieve"); @http.get("/subscriptions/#{id}/") ; end
      def create(customer:, plan:, **o); @http.assert_secret_key!("subscriptions.create"); @http.post("/subscriptions/", {customer: customer, plan: plan}.merge(o)); end
      def update(id, **p); @http.assert_secret_key!("subscriptions.update"); @http.patch("/subscriptions/#{id}/", p); end
      def cancel(id, **o); @http.assert_secret_key!("subscriptions.cancel"); @http.post("/subscriptions/#{id}/cancel/", o); end
      def pause(id)      ; @http.assert_secret_key!("subscriptions.pause") ; @http.post("/subscriptions/#{id}/pause/"); end
      def resume(id)     ; @http.assert_secret_key!("subscriptions.resume"); @http.post("/subscriptions/#{id}/resume/"); end
      def options; @http.options("/subscriptions/"); end

    end
  end
end
