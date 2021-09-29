class SearchParamsController < ApplicationController

  def index
    @search_params = SearchParam.all
  end

  def show
    @search_param = SearchParam.find(params[:id])
  end

  def new
    @search_param = SearchParam.new
  end 

  def create
    @search_param = SearchParam.new(search_param_params)
    #byebug
    if @search_param.save
      flash[:notice] = "Search Created Succesfully!"
      redirect_to search_params_path
    else
      render 'new'
    end
  end 

  def edit
    @search_param = SearchParam.find(params[:id])
  end

  def update
    @search_param = SearchParam.find(params[:id])
    if @search_param.update(search_param_params)
      flash[:notice] = "Search Updated Succesfully"
      redirect_to search_params_path
    else
      render('edit')
    end
  end

  def destroy
    @search_param = SearchParam.find(params[:id])
    @search_param.destroy
    flash[:notice] = "Search Deleted Succesfully"
    redirect_to search_params_path
  end

  private

  def search_param_params
    params.require(:search_param).permit(:title, :comuna)
  end




end