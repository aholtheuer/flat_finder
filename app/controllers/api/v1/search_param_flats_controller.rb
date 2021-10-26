module Api
  module V1    
    class SearchParamFlatsController < ApplicationController
      skip_before_action :verify_authenticity_token
      
      def update
        @search_param_flat = SearchParamFlat.find(params[:id])
        if @search_param_flat.update(search_param_flat_params)
          render json: { status: :ok, message: 'Success' }
        else
          render json: { json: @user.errors, status: :unprocessable_entity }

        end
      end

      private

      def search_param_flat_params
        params.require(:search_param_flat).permit(:id, :liked)
      end
    end
  end
end
