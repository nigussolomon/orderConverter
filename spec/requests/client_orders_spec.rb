# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ClientOrders', type: :request do
  include_examples('request_shared_spec', 'client_orders', 10)

  let(:valid_attributes) do
    {
      order_number: Faker::Alphanumeric.alpha(number: 10),
      order_date: Date.current,
      delivery_date: Date.current.advance(month: 1),
      client_id: create(:client).id,
      terms: { payment_terms: 'NET 30 days', currency: 'Euro', freight_terms: 'FOB' },
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
          price: 1300 }
      ] }
    }
  end

  let(:invalid_attributes) do
    {
      order_number: nil,
      order_date: Date.current,
      delivery_date: Date.current.advance(month: 1),
      client_id: create(:client).id,
      terms: { payment_terms: 'NET 30 days', currency: 'Euro', freight_terms: 'FOB' },
      status: Comee::Core::ClientOrder.statuses[:draft],
      delivery_address: Faker::Address.full_address,
      invoice_address: Faker::Address.full_address,
      remark: Faker::Lorem.sentence
    }
  end

  let(:new_attributes) do
    {
      delivery_date: Date.current.advance(month: 2)
    }
  end

  let(:update_attr) do
    {
      delivery_date: Date.current.advance(month: 2),
      items: { products: [
        { code: Faker::Alphanumeric.alpha(number: 6),
          name: Faker::Name.name,
          description: Faker::Lorem.sentence,
          product_type_id: create(:product_type).id,
          unit_id: create(:unit).id,
          metadata: {},
          quantity: 100,
          price: 1200 }
      ] }
    }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new client order and creates client order items along side' do
        expect do
          post(
            send('client_orders_url'),
            headers:,
            params: { payload: valid_attributes },
            as: :json
          )
        end.to change(Comee::Core::ClientOrder, :count).by(1)
        expect(Comee::Core::Product.all.count).to eq 2
        expect(Comee::Core::ClientOrderItem.all.count).to eq 2
      end
    end
  end

  it 'filters the orders for a specific client' do
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

  it 'filters client orders given a client id' do
    cl_az = create(:client)
    cl_ap = create(:client)
    create(:client_order, client_id: cl_az.id)
    create(:client_order, client_id: cl_az.id)
    create(:client_order, client_id: cl_ap.id)

    get "/client_orders/filter/#{cl_az.id}"
    expect(response).to be_successful
    expect(JSON.parse(response.body)['data'].count).to eq 2
  end

  it 'updates client order items' do
    co = create(:client_order)
    prod1 = create(:product, code: update_attr[:items][:products][0][:code])
    coi1 = create(:client_order_item, client_order_id: co.id, product_id: prod1.id)

    put(
      send('client_order_url', id: co.id),
      headers:,
      params: { payload: update_attr },
      as: :json
    )

    expect(response).to be_successful
    expect(Comee::Core::ClientOrder.find(co.id).delivery_date).to eq update_attr[:delivery_date]
    expect(Comee::Core::ClientOrderItem.find(coi1.id).quantity).to eq update_attr[:items][:products][0][:quantity]
  end
end
