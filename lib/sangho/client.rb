# frozen_string_literal: true

require_relative 'http_client'
require_relative 'resources/base_resource'
require_relative 'resources/apps'
require_relative 'resources/customers'
require_relative 'resources/products'
require_relative 'resources/payment_intents'
require_relative 'resources/payment_links'
require_relative 'resources/checkout_sessions'
require_relative 'resources/invoices'
require_relative 'resources/transactions'
require_relative 'resources/refunds'
require_relative 'resources/subscriptions'
require_relative 'resources/payment_methods'
require_relative 'resources/receipts'
require_relative 'resources/webhooks'
require_relative 'resources/security'
require_relative 'resources/partners'

module Sangho
  # Client for interacting with the Sangho API.
  # Provides access to resources such as apps, customers, products, payment intents, and more.
  class SanghoClient
    attr_reader :apps, :customers, :products, :payment_intents, :payment_links,
                :checkout_sessions, :invoices, :transactions, :refunds,
                :subscriptions, :payment_methods, :receipts, :webhooks,
                :security, :partners

    def initialize(api_key: Sangho.api_key, base_url: Sangho.base_url, timeout: Sangho.timeout)
      raise ArgumentError, 'api_key is required' unless api_key

      http = HttpClient.new(api_key: api_key, base_url: base_url, timeout: timeout)
      initialize_resources(http)
    end

    private

    RESOURCE_CLASSES = {
      apps: Resources::Apps,
      customers: Resources::Customers,
      products: Resources::Products,
      payment_intents: Resources::PaymentIntents,
      payment_links: Resources::PaymentLinks,
      checkout_sessions: Resources::CheckoutSessions,
      invoices: Resources::Invoices,
      transactions: Resources::Transactions,
      refunds: Resources::Refunds,
      subscriptions: Resources::Subscriptions,
      payment_methods: Resources::PaymentMethods,
      receipts: Resources::Receipts,
      webhooks: Resources::Webhooks,
      security: Resources::Security,
      partners: Resources::Partners
    }.freeze

    def initialize_resources(http)
      RESOURCE_CLASSES.each { |key, klass| instance_variable_set("@#{key}", klass.new(http)) }
    end
  end
end
