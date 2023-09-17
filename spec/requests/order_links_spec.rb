require "rails_helper"

RSpec.describe "OrderLinks", type: :request do
  include_examples("request_shared_spec", "order_links", 3)

  let(:valid_attributes) {
    {
      link: Faker::Internet.url,
      client_id: create(:client).id,
    }
  }

  let(:invalid_attributes) {
    {
      link: nil,
      client_id: nil,
    }
  }

  let(:new_attributes) {
    {
      link: Faker::Internet.url,
    }
  }

  it "filters order links given a client id" do
    cl_az = create(:client)
    cl_ap = create(:client)
    create(:order_link, client_id: cl_az.id)
    create(:order_link, client_id: cl_az.id)
    create(:order_link, client_id: cl_ap.id)

    get "/order_links/filter/#{cl_az.id}"
    expect(response).to be_successful
    expect(JSON.parse(response.body)["data"].count).to eq(2)
  end
end
