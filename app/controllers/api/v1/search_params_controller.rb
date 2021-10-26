module Api
  module V1  
    class SearchParamsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_search_param
      before_action :user_signed_in?
      before_action :requiere_same_user

      def destroy
        byebug
        @search_param.destroy
        flash[:notice] = "Search Deleted Succesfully"
        redirect_to current_user
      end

      private

      def set_search_param
        @search_param = SearchParam.find(params[:id])
      end

      def requiere_same_user
        if @search_param.user != current_user
          flash.alert = "You can only edit your own searches"
          redirect_to current_user
        end
      end

    end
  end
end
