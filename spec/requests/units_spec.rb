# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Units', type: :request do
  include_examples('request_shared_spec', 'units', 4)

  let(:valid_attributes) do
    {
      code: Faker::Code.npi,
      name: Faker::Name.name,
      unit_type: 1
    }
  end

  let(:invalid_attributes) do
    {
      code: nil,
      name: Faker::Name.name,
      unit_type: 1
    }
  end

  let(:new_attributes) do
    {
      code: Faker::Code.npi
    }
  end
end
