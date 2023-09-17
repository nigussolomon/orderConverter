class ClientsController < ApplicationController
  include Common

  

  private

  def model_params
    params.require(:payload).permit(:code, :name, :address, :locale, :user_id)
  end
end
