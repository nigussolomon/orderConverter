require 'rails_helper'

RSpec.describe "Units", type: :request do
  include_examples("request_shared_spec", "units", 3)

  let(:valid_attributes) {
    {
      code: Faker::Code.npi,
      name: Faker::Name.name,
      unit_type: 1,
    }
  }

  let(:invalid_attributes) {
    {
      code: nil,
      name: Faker::Name.name,
      unit_type: 1,
    }
  }

  let(:new_attributes) {
    {
      code: Faker::Code.npi,
    }
  }

end
