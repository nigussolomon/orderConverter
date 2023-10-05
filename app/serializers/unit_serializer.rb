# frozen_string_literal: true

class UnitSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :unit_type
end
