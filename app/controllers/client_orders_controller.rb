class ClientOrdersController < ApplicationController
  include Common

  def model_params
    params.require(:payload).permit(:order_number, :order_date, :delivery_date, :client_id, :status, :delivery_address, :invoice_address, :remark, terms: {})
  end
end
