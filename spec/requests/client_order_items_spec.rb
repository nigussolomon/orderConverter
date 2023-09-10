require "rails_helper"

RSpec.describe "ClientOrderItems", type: :request do
  include_examples("request_shared_spec", "client_order_items", 7)

  let(:valid_attributes) {
    {
      client_order_id: create(:client_order).id,
      product_id: create(:product).id,
      quantity: 100,
      price: 50,
    }
  }

  let(:invalid_attributes) {
    {
      client_order_id: create(:client_order).id,
      product_id: create(:product).id,
      quantity: 100,
      price: nil,
    }
  }

  let(:new_attributes) {
    {
      quantity: 110,
    }
  }
end
