class CurrenciesController < ApplicationController
    include Common

    private 

    def model_paramas
        params.require(:payload).permit(:code, :name)
    end
end