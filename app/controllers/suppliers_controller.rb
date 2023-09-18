class SuppliersController < ApplicationController
  include Common

  def model_params
    params.require(:payload).permit(:code, :name, :address, :locale, :locale)
  end
end