require "rails_helper"

RSpec.describe "ProductTypes", type: :request do
  include_examples("request_shared_spec", "product_types", 5)

  let(:valid_attributes) {
    {
      code: Faker::Code.npi,
      name: Faker::Lorem.word,
      description: Faker::Lorem.sentence,
    }
  }

  let(:invalid_attributes) {
    {
      code: nil,
      name: Faker::Lorem.word,
      address: Faker::Address.full_address,
    }
  }

  let(:new_attributes) {
    {
      name: Faker::Lorem.word,
    }
  }
end
