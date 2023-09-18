class OrderSourceController < ApplicationController

    include Common

    private

    def model_params
        params.require(:payload).permit(:name, :client_id)
    end

end
