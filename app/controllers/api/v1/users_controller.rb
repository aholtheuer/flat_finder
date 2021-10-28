module Api
  module V1    
    class UsersController < ApplicationController
      # DELETE /users/1 or /users/1.json
      def destroy
        @user = User.find(params[:id])
        
        if @user != current_user
          flash.alert = "You can only edit your own user data"
          redirect_to edit_user_path(current_user)
        end

        @user.destroy
        flash.notice = "User deleted Successfully"
        render json: { json: 'User was successfully deleted'}
      end

    end
  end
end