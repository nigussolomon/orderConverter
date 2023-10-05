# frozen_string_literal: true

class ClientOrderSerializer < ActiveModel::Serializer
  attributes :id, :order_number, :order_date, :delivery_date, :delivery_address, :invoice_address, :terms, :status,
    :client, :remark
end
