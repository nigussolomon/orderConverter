require "rails_helper"

RSpec.describe "ClientOrders", type: :request do
  include_examples("request_shared_spec", "client_orders", 10)

  let(:valid_attributes) {
    {
      order_number: Faker::Alphanumeric.alpha(number: 10),
      order_date: Date.current,
      delivery_date: Date.current.advance(month: 1),
      client_id: create(:client).id,
      terms: { payment_terms: "NET 30 days", currency: "Euro", freight_terms: "FOB" },
      status: Comee::Core::ClientOrder.statuses[:draft],
      delivery_address: Faker::Address.full_address,
      invoice_address: Faker::Address.full_address,
      remark: Faker::Lorem.sentence,
    }
  }

  let(:invalid_attributes) {
    {
      order_number: nil,
      order_date: Date.current,
      delivery_date: Date.current.advance(month: 1),
      client_id: create(:client).id,
      terms: { payment_terms: "NET 30 days", currency: "Euro", freight_terms: "FOB" },
      status: Comee::Core::ClientOrder.statuses[:draft],
      delivery_address: Faker::Address.full_address,
      invoice_address: Faker::Address.full_address,
      remark: Faker::Lorem.sentence,
    }
  }

  let(:new_attributes) {
    {
      delivery_date: Date.current.advance(month: 2),
    }
  }
end
