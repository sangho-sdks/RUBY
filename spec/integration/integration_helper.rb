# frozen_string_literal: true

# Sangho Ruby SDK — Integration test helper
#
# Variables d'environnement requises :
#   SANGHO_TEST_SECRET_KEY   sk_test_xxx
#   SANGHO_TEST_PUBLIC_KEY   pk_test_xxx  (optionnel)
#   SANGHO_API_BASE_URL      https://api.sangho.com/v1 (optionnel)
#
# Lancement :
#   SANGHO_TEST_SECRET_KEY=sk_test_xxx bundle exec rspec spec/integration/
#   # ou via Makefile :
#   make test-integration

require "sangho"

module IntegrationHelper
  def self.secret_key
    ENV["SANGHO_TEST_SECRET_KEY"]
  end

  def self.public_key
    ENV["SANGHO_TEST_PUBLIC_KEY"]
  end

  def self.base_url
    ENV["SANGHO_API_BASE_URL"] || "https://api.sangho.com/v1"
  end

  def self.enabled?
    !secret_key.nil? && !secret_key.empty?
  end
end

RSpec.shared_context "integration" do
  before(:all) do
    skip "SANGHO_TEST_SECRET_KEY not set — integration tests skipped" unless IntegrationHelper.enabled?
  end

  let(:client) do
    Sangho.new(
      IntegrationHelper.secret_key,
      base_url: IntegrationHelper.base_url
    )
  end

  let(:pub_client) do
    skip "SANGHO_TEST_PUBLIC_KEY not set" unless IntegrationHelper.public_key
    Sangho.new(
      IntegrationHelper.public_key,
      base_url: IntegrationHelper.base_url
    )
  end

  def unique_email(prefix = "test")
    "#{prefix}-#{SecureRandom.hex(4)}@sangho-test.com"
  end

  def unique_name(prefix = "Test")
    "#{prefix} #{SecureRandom.hex(3).upcase}"
  end
end

RSpec.configure do |config|
  config.include_context "integration", integration: true
end
