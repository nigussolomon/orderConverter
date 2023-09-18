class ProductTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :metadata_schema
end
