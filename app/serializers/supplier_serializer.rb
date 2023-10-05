# frozen_string_literal: true

class SupplierSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :address, :locale, :user
end
