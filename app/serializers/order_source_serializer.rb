# frozen_string_literal: true

class OrderSourceSerializer < ActiveModel::Serializer
  attributes :id, :name, :client
end
