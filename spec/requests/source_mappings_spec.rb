require "rails_helper"

RSpec.describe "SourceMappings", type: :request do
  include_examples("request_shared_spec", "source_mappings", 6)

  let(:valid_attributes) {
    {
      source: Faker::Lorem.word,
      destination: Faker::Lorem.word,
      order_source_id: create(:order_source).id,
    }
  }

  let(:invalid_attributes) {
    {
      source: Faker::Lorem.word,
      destination: Faker::Lorem.word,
      order_source_id: nil,
    }
  }

  let(:new_attributes) {
    {
      source: Faker::Lorem.word,
    }
  }
end
