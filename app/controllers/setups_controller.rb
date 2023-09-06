require "httparty"
require "savon"
require "date"

class SetupsController < ApplicationController
  AUTH = "Basic 425655:C61B8D76C8CA5889DDC2:hDKTnfHMaw!bBPqP"

  def get_items
    url = "https://login.salesorder.com/salesorder/api/v1/items/type/StockItem"
    headers = { "Authorization" => AUTH }

    begin
      response = HTTParty.get(url, headers: headers)
      data = JSON.parse(response.body)

      type = Comee::Core::ProductType.find_by(name: "Stock Item")
      unit = Comee::Core::Unit.find_by(name: "Each")
      products = []

      data.each do |product|
        products << {
          code: product["itemCode"],
          name: product["description"],
          description: product["description"],
          product_type_id: type.id,
          unit_id: unit.id,
        }
      end

      Comee::Core::Product.insert_all(products)
      render json: products
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :unprocessable_entity
    end
  end

  def get_customers
    url = "https://login.salesorder.com/salesorder/api/v1/tradingpartners/type/Customer"
    headers = { "Authorization" => AUTH }

    response = HTTParty.get(url, headers: headers)
    data = JSON.parse(response.body)

    begin
      response = HTTParty.get(url, headers: headers)
      data = JSON.parse(response.body)

      customers = []

      data.each do |customer|
        user = Comee::Core::User.create(name: customer["partnerName"], email: "#{customer["partnerName"]}@mavecko.com", password: "MAVEKO123#", user_type: 0)
        customers << {
          code: customer["objectUID"],
          name: customer["partnerName"],
          address: customer["country"],
          user_id: user.id,
        }
      end

      Comee::Core::Client.insert_all(customers)
      render json: customers
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :unprocessable_entity
    end
  end

  def get_suppliers
    url = "https://login.salesorder.com/salesorder/api/v1/tradingpartners/type/Supplier"
    headers = { "Authorization" => AUTH }

    response = HTTParty.get(url, headers: headers)
    data = JSON.parse(response.body)

    begin
      response = HTTParty.get(url, headers: headers)
      data = JSON.parse(response.body)

      suppliers = []

      data.each do |supplier|
        user = Comee::Core::User.create(name: supplier["partnerName"], email: "#{supplier["partnerName"]}@mavecko.com", password: "MAVEKO123#", user_type: 0)
        suppliers << {
          code: supplier["objectUID"],
          name: supplier["partnerName"],
          address: supplier["country"],
          user_id: user.id,
        }
      end

      Comee::Core::Supplier.insert_all(suppliers)
      render json: suppliers
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :unprocessable_entity
    end
  end

  def get_so
    url = "https://login.salesorder.com/salesorder/api/v1/transactions/#{params[:poNumber]}"
    headers = { "Authorization" => AUTH }

    response = HTTParty.get(url, headers: headers)
    data = JSON.parse(response.body)

    render json: { data: data, success: true }, status: :ok
  end

  def create_so
    mxp_po = HTTParty.get("http://localhost:8000/so_items?po_login_code=#{params[:poNumber]}&user_full_name=orderConverter.api")
    parsed_json = JSON.parse(mxp_po.body)

    header = parsed_json["header"]
    details = parsed_json["details"]

    url = "https://login.salesorder.com/salesorder/api/v1/transactions/SalesOrder"
    headers = { "Authorization" => AUTH, "Content-Type" => "application/json" }
    # sent_date = Date.parse(header["__values__"]["POSentDate"]).strftime("%d/%m/%Y")
    delivery_date = Date.parse(header["__values__"]["DeliveryDateToDestination"]).strftime("%d/%m/%Y")
    body = {
      "date" => Date.today.strftime("%d/%m/%Y"),
      "objectUID" => header["__values__"]["PONumber"],
      "tpRef" => "D129993",
      "status" => "PENDING",
      "dateRequired" => delivery_date,
      "dateExpected" => delivery_date,
      "lineItems" => [
        {
          "quantity" => "1111",
          "unitCost" => "101.11",
          "isDiscountFixed" => true,
          "itemCode" => "M200000",
        },
      ],
    }

    begin
      response = HTTParty.post(url, headers: headers, body: body.to_json)
      render json: { success: true }, status: :ok
    rescue StandardError => e
      render json: { success: false, error: e.message }, status: :internal_server_error
    end
  end

  def create_po
    mxp_po = HTTParty.get("http://localhost:8000/so_items?po_login_code=#{params[:poNumber]}&user_full_name=orderConverter.api")
    parsed_json = JSON.parse(mxp_po.body)

    header = parsed_json["header"]
    details = parsed_json["details"]

    url = "https://login.salesorder.com/salesorder/api/v1/transactions/PurchaseOrder"
    headers = { "Authorization" => "Basic 425655:C61B8D76C8CA5889DDC2:hDKTnfHMaw!bBPqP", "Content-Type" => "application/json" }
    sent_date = Date.parse(header["__values__"]["POSentDate"]).strftime("%d/%m/%Y")
    delivery_date = Date.parse(header["__values__"]["DeliveryDateToDestination"]).strftime("%d/%m/%Y")
    body = {
      "date" => sent_date,
      "objectUID" => header["__values__"]["PONumber"] + "1",
      "tpRef" => "K720000",
      "status" => "PENDING",
      "dateRequired" => delivery_date,
      "dateExpected" => delivery_date,
      "reference" => "460164.SalesOrder",
      "lineItems" => [
        {
          "quantity" => "1111",
          "unitCost" => "101.11",
          "isDiscountFixed" => true,
          "itemCode" => "M200000",
        },
      ],
    }

    begin
      response = HTTParty.post(url, headers: headers, body: body.to_json)
      render json: { success: true }, status: :ok
    rescue StandardError => e
      render json: { success: false, error: e.message }, status: :internal_server_error
    end
  end
end
