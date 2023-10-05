# frozen_string_literal: true

class ClientOrdersController < ApplicationController
  include Common

  def create
    if model_params["items"].present?
      order_items = model_params["items"]["products"]
      params[:payload].delete("items")
      client_order = Comee::Core::ClientOrder.new(model_params)
      if client_order.save
        order_items.each do |product|
          prod = Comee::Core::Product.where(code: product["code"], name: product["name"],
            description: product["description"], metadata: product["metadata"], product_type_id: product["product_type_id"], unit_id: product["unit_id"]).first_or_create
          Comee::Core::ClientOrderItem.create(client_order_id: client_order.id, product_id: prod.id,
            quantity: product["quantity"], price: product["price"])
        end
        render json: {success: true, data: serialize(client_order)}, status: :created
      else
        render json: {success: false, error: client_order.errors.full_messages[0]}, status: :unprocessable_entity
      end
    else
      render json: {success: false, error: "No items found, can't create an order!"}, status: :unprocessable_entity
    end
  end

  def update
    client_order = Comee::Core::ClientOrder.find(params[:id])
    if model_params["items"].present?
      order_items = model_params["items"]["products"]
      params[:payload].delete("items")
      if client_order.update(model_params)
        order_items.each do |product|
          product_id = Comee::Core::Product.find_by(code: product["code"]).id
          puts product
          Comee::Core::ClientOrderItem.find_by(product_id:).update!(quantity: product["quantity"],
            price: product["price"])
        end
        render json: {success: true, data: serialize(client_order)}, status: :ok
      else
        render json: {success: false, error: client_order.errors.full_messages[0]}, status: :unprocessable_entity
      end
    elsif client_order.update(model_params)
      render json: {success: true, data: serialize(client_order)}, status: :ok
    else
      render json: {success: false, error: client_order.errors.full_messages[0]}, status: :unprocessable_entity
    end
  end

  def order_details
    ccoi = Comee::Core::ClientOrderItem.where(client_order_id: params["id"])
    render json: {success: false, data: serialize(ccoi)}, status: :ok
  end

  def filter
    cos = Comee::Core::ClientOrder.where(client_id: params[:id])
    render json: {succes: true, data: serialize(cos)}, status: :ok
  end

  private

  def model_params
    params.require(:payload).permit(:order_number, :order_date, :delivery_date, :client_id, :status, :delivery_address,
      :invoice_address, :remark, terms: {}, items: {})
  end
end
