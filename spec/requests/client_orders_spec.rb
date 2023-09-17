require "rails_helper"

RSpec.describe "ClientOrders", type: :request do
  include_examples("request_shared_spec", "client_orders", 10)

  let(:valid_attributes) {
    {
      order_number: Faker::Alphanumeric.alpha(number: 10),
      order_date: Date.current,
      delivery_date: Date.current.advance(month: 1),
      client_id: create(:client).id,
      terms: { payment_terms: "NET 30 days", currency: "Euro", freight_terms: "FOB" },
      status: Comee::Core::ClientOrder.statuses[:draft],
      delivery_address: Faker::Address.full_address,
      invoice_address: Faker::Address.full_address,
      remark: Faker::Lorem.sentence,
      items: { products: [
        { code: Faker::Alphanumeric.alpha(number: 6),
          name: Faker::Name.name,
          description: Faker::Lorem.sentence,
          product_type_id: create(:product_type).id,
          unit_id: create(:unit).id,
          metadata: {},
          quantity: 100,
          price: 1200 },
        { code: Faker::Alphanumeric.alpha(number: 6),
          name: Faker::Name.name,
          description: Faker::Lorem.sentence,
          product_type_id: create(:product_type).id,
          unit_id: create(:unit).id,
          metadata: {},
          quantity: 110,
          price: 1300 },
      ] },
    }
  }

  let(:invalid_attributes) {
    {
      order_number: nil,
      order_date: Date.current,
      delivery_date: Date.current.advance(month: 1),
      client_id: create(:client).id,
      terms: { payment_terms: "NET 30 days", currency: "Euro", freight_terms: "FOB" },
      status: Comee::Core::ClientOrder.statuses[:draft],
      delivery_address: Faker::Address.full_address,
      invoice_address: Faker::Address.full_address,
      remark: Faker::Lorem.sentence,
    }
  }

  let(:new_attributes) {
    {
      delivery_date: Date.current.advance(month: 2),
    }
  }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new client order and creates client order items along side" do
        expect do
          post(
            send("client_orders_url"),
            headers: headers,
            params: { payload: valid_attributes },
            as: :json,
          )
        end.to change(Comee::Core::ClientOrder, :count).by(1)
        expect(Comee::Core::Product.all.count).to eq 2
        expect(Comee::Core::ClientOrderItem.all.count).to eq 2
      end
    end
  end

  describe "GET #order_details" do
    it "creates a new client order and creates client order items along side" do
      co_az = create(:client_order)
      co_ap = create(:client_order)
      create(:client_order_item, client_order_id: co_az.id)
      create(:client_order_item, client_order_id: co_az.id)
      create(:client_order_item, client_order_id: co_ap.id)

      get "/order_details/#{co_az.id}"
      result = JSON(response.body)
      expect(response).to be_successful
      expect(result.count).to eq 2
    end
  end
end
