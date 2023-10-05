# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Suppliers", type: :request do
  include_examples("request_shared_spec", "suppliers", 5)

  let(:valid_attributes) do
    {
      code: Faker::Code.npi,
      name: Faker::Lorem.word,
      address: Faker::Address.full_address,
      locale: "en",
      user_id: create(:user).id
    }
  end

  let(:invalid_attributes) do
    {
      code: nil,
      name: Faker::Lorem.word,
      address: Faker::Address.full_address,
      locale: "en",
      user_id: nil
    }
  end

  let(:new_attributes) do
    {
      name: Faker::Lorem.word
    }
  end
end
