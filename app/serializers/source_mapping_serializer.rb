class SourceMappingSerializer < ActiveModel::Serializer
  attributes :id, :source, :destination, :order_source
end
