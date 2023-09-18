require 'rails_helper'

RSpec.describe "Currencies", type: :request do
  include_examples("request_shared_spec", "currencies", 4)

  let(:valid_attributes) {
    {
      code: Faker::Code.npi,
      name: Faker::Name.name,
    }
  }

  let(:invalid_attributes) {
    {
      code: nil,
      name: Faker::Name.name,
    }
  }

  let(:new_attributes) {
    {
      name: Faker::Name.name,
    }
  }
end
