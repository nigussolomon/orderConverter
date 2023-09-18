class UnitsController < ApplicationController

    include Common 
    
    private
    
    def model_params
        params.require(:payload).permit(:code, :name, :unit_type)
    end 
    
    end
    