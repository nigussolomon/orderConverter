class ClientOrderItemSerializer < ActiveModel::Serializer
  attributes :id, :client_order, :product, :quantity, :price
end
