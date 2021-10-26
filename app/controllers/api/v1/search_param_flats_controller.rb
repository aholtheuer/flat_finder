module Api
  module V1    
    class SearchParamFlatsController < ApplicationController
      skip_before_action :verify_authenticity_token
      # before_action :set_search_param, only: [:show, :edit, :update, :destroy]
      # before_action :user_signed_in?
      # before_action :requiere_same_user, only: [:show, :edit, :update, :destroy]

      def update
        @search_param_flat = SearchParamFlat.find(params[:id])
        if @search_param_flat.update(search_param_flat_params)
          render json: { status: :ok, message: 'Success' }
        else
          render json: { json: @user.errors, status: :unprocessable_entity }
        # if @search_param.update(search_param_params)
        #   # Flats are not longer representative of that search.
        #   SearchParamFlat.where({search_param_id: @search_param.id}).destroy_all
        #   run_and_schedule_spider_job
        #   flash[:notice] = "Search Updated Succesfully! A Spider is entring the portals :)"
        #   redirect_to @search_param.user
        # else
        #   render('edit')
        end
      end

      private

      def search_param_flat_params
        params.require(:search_param_flat).permit(:id, :liked)
      end

      # def set_search_param
      #   @search_param = SearchParam.find(params[:id])
      # end


      # def requiere_same_user
      #   if @search_param.user != current_user
      #     flash.alert = "You can only edit your own searches"
      #     redirect_to current_user
      #   end
    end
  end
end
