class SearchParamsController < ApplicationController
  before_action :set_search_param, only: [:show, :edit, :update, :destroy]
  before_action :require_user
  before_action :requiere_same_user, only: [:show, :edit, :update, :destroy]

  def index
    @search_params = SearchParam.all
    flash.alert = "You are not authorized to perform that action"
    redirect_to current_user
  end

  def show
  end

  def new
    @search_param = SearchParam.new
  end 

  def create
    @search_param = SearchParam.new(search_param_params)
    @search_param.user = current_user
    if @search_param.save
      flash[:notice] = "Search Created Succesfully!"
      redirect_to @search_param
    else
      render 'new'
    end
  end 

  def edit
  end

  def update
    if @search_param.update(search_param_params)
      flash[:notice] = "Search Updated Succesfully"
      redirect_to @search_param
    else
      render('edit')
    end
  end

  def destroy
    @search_param.destroy
    flash[:notice] = "Search Deleted Succesfully"
    redirect_to current_user
  end

  private

  def search_param_params
    params.require(:search_param).permit(:title, :comuna, :bedroom, :bath, :price_min, :price_max)
  end

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