# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OrderSources', type: :request do
  include_examples('request_shared_spec', 'order_sources', 3)

  let(:valid_attributes) do
    {
      name: Faker::Name.name,
      client_id: create(:client).id
    }
  end

  let(:invalid_attributes) do
    {
      name: Faker::Name.name,
      client_id: nil
    }
  end

  let(:new_attributes) do
    {
      name: Faker::Name.name
    }
  end
end
