require 'rails_helper'

RSpec.describe "Suppliers", type: :request do
  include_examples("request_shared_spec", "suppliers", 6)

  let(:valid_attributes) {
    {
      code: Faker::Code.npi,
      name: Faker::Lorem.word,
      address: Faker::Address.full_address,
      locale: 'en',
      user_id: create(:user).id
    }
  }

  let(:invalid_attributes) {
    {
      code: Faker::Code.npi,
      name: Faker::Lorem.word,
      address: Faker::Address.full_address,
      locale: 'en',
      user_id: nil
    }
  }

  let(:new_attributes) {
    {
      name: Faker::Lorem.word,
    }
  }
end
