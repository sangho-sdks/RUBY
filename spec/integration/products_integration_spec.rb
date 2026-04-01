# frozen_string_literal: true

require_relative "../spec_helper"
require_relative "integration_helper"

RSpec.describe "Products Integration", :integration do

  let!(:shared_product) do
    client.products.create(name: unique_name("Product"), price: 5000, description: "Integration test")
  end

  after(:all) do
    begin; client.products.delete(shared_product[:id]); rescue StandardError; nil; end
  end

  describe "#create" do
    it "creates a product with correct fields" do
      product = client.products.create(name: unique_name("Create"), price: 12_000)

      expect(product[:id]).not_to be_empty
      expect(product[:price]).to eq(12_000)
      expect(product).to have_key(:created_at)

      client.products.delete(product[:id])
    end
  end

  describe "#retrieve" do
    it "retrieves a product by id" do
      retrieved = client.products.retrieve(shared_product[:id])
      expect(retrieved[:id]).to eq(shared_product[:id])
      expect(retrieved[:name]).to eq(shared_product[:name])
    end
  end

  describe "#list" do
    it "returns a paginated response" do
      result = client.products.list(page_size: 5)
      expect(result).to have_key(:count)
      expect(result[:results]).to be_an(Array)
      expect(result[:results].length).to be <= 5
    end
  end

  describe "#update" do
    it "updates the product price" do
      updated = client.products.update(shared_product[:id], price: 9999)
      expect(updated[:price]).to eq(9999)
    end
  end

  describe "#archive and #restore" do
    it "archives then restores a product" do
      product  = client.products.create(name: unique_name("Archive"), price: 1000)
      archived = client.products.archive(product[:id])
      expect(%w[archived inactive]).to include(archived[:status].to_s)

      restored = client.products.restore(product[:id])
      expect(restored[:status].to_s).to eq("active")

      client.products.delete(product[:id])
    end
  end

  describe "#delete" do
    it "deletes a product and raises NotFound on retrieve" do
      product = client.products.create(name: unique_name("Del"), price: 500)
      client.products.delete(product[:id])

      expect { client.products.retrieve(product[:id]) }
        .to raise_error(Sangho::SanghoNotFoundError)
    end
  end

  describe "error handling" do
    it "raises SanghoNotFoundError on nonexistent product" do
      expect { client.products.retrieve("prod_doesnotexist000") }
        .to raise_error(Sangho::SanghoNotFoundError)
    end
  end
end
