# frozen_string_literal: true

class SourceMappingsController < ApplicationController
  include Common

  def model_params
    params.require(:payload).permit(:source, :destination, :order_source_id)
  end
end
