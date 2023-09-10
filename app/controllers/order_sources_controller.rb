class OrderSourcesController < ApplicationController
  include Common

  def model_params
    params.require(:payload).permit(:name, :client_id)
  end
end
