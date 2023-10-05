# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ProductTypes', type: :request do
  include_examples('request_shared_spec', 'product_types', 5)

  let(:valid_attributes) do
    {
      code: Faker::Code.npi,
      name: Faker::Lorem.word,
      description: Faker::Lorem.sentence
    }
  end

  let(:invalid_attributes) do
    {
      code: nil,
      name: Faker::Lorem.word,
      address: Faker::Address.full_address
    }
  end

  let(:new_attributes) do
    {
      name: Faker::Lorem.word
    }
  end
end
