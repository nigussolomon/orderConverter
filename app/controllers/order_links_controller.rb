# frozen_string_literal: true

class OrderLinksController < ApplicationController
  include Common

  def filter
    ols = Comee::Core::OrderLink.where(client_id: params[:id])
    render json: { succes: true, data: serialize(ols) }, status: :ok
  end

  private

  def model_params
    params.require(:payload).permit(:link, :client_id)
  end
end
