# frozen_string_literal: true

class ProductTypesController < ApplicationController
  include Common

  def model_params
    params.require(:payload).permit(:code, :name, :description, :metadata_schema)
  end
end
