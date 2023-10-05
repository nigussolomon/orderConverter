# frozen_string_literal: true

class ProductTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :metadata_schema
end
