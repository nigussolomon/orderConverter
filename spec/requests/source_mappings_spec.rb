# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SourceMappings', type: :request do
  include_examples('request_shared_spec', 'source_mappings', 4)

  let(:valid_attributes) do
    {
      source: Faker::Lorem.word,
      destination: Faker::Lorem.word,
      order_source_id: create(:order_source).id
    }
  end

  let(:invalid_attributes) do
    {
      source: Faker::Lorem.word,
      destination: Faker::Lorem.word,
      order_source_id: nil
    }
  end

  let(:new_attributes) do
    {
      source: Faker::Lorem.word
    }
  end
end
