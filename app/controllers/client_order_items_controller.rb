class ClientOrderItemsController < ApplicationController
  include Common

  def model_params
    params.require(:payload).permit(:client_order_id, :product_id, :quantity, :price)
  end
end
