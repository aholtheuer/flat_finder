class SessionsController < ApplicationController

  def new
  end

  def create 
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.username}!"
      redirect_to search_params_path
    else
      flash.now.alert = "There was something wrong with your login"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully Logged Out"
    redirect_to login_path
  end
end
