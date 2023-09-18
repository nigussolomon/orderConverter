class SupplierSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :address, :locale, :user
end
