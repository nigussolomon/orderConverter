# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ClientOrderItems", type: :request do
  include_examples("request_shared_spec", "client_order_items", 5)

  let(:valid_attributes) do
    {
      client_order_id: create(:client_order).id,
      product_id: create(:product).id,
      quantity: 100,
      price: 50
    }
  end

  let(:invalid_attributes) do
    {
      client_order_id: create(:client_order).id,
      product_id: create(:product).id,
      quantity: 100,
      price: nil
    }
  end

  let(:new_attributes) do
    {
      quantity: 110
    }
  end
end
