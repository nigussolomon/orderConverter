# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Currencies', type: :request do
  include_examples('request_shared_spec', 'currencies', 3)

  let(:valid_attributes) do
    {
      code: Faker::Code.npi,
      name: Faker::Name.name
    }
  end

  let(:invalid_attributes) do
    {
      code: nil,
      name: Faker::Name.name
    }
  end

  let(:new_attributes) do
    {
      name: Faker::Name.name
    }
  end
end
