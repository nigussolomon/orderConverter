# frozen_string_literal: true

class OrderLinkSerializer < ActiveModel::Serializer
  attributes :id, :link, :client
end
