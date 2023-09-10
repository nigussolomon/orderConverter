require "rails_helper"

RSpec.describe "OrderSources", type: :request do
  include_examples("request_shared_spec", "order_sources", 3)

  let(:valid_attributes) {
    {
      name: Faker::Name.name,
      client_id: create(:client).id,
    }
  }

  let(:invalid_attributes) {
    {
      name: Faker::Name.name,
      client_id: nil,
    }
  }

  let(:new_attributes) {
    {
      name: Faker::Name.name,
    }
  }
end
