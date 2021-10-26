class SearchParamsController < ApplicationController
  before_action :set_search_param, only: [:show, :edit, :update, :destroy]
  before_action :user_signed_in?
  before_action :requiere_same_user, only: [:show, :edit, :update, :destroy]

  def index
    @search_params = SearchParam.all
    # flash.alert = "You are not authorized to perform that action"
    # redirect_to current_user
  end

  def show
    @flats = Flat.select("flats.*, search_param_flats.id as search_param_flat_id, search_param_flats.*")
      .joins(:search_param_flats)
      .where(search_param_flats: { search_param_id: @search_param.id })
      .order(emailed_at: :desc)
  end

  def new
    @search_param = SearchParam.new
  end

  def create
    @search_param = SearchParam.new(search_param_params)
    @search_param.user = current_user
    if @search_param.save
      run_and_schedule_spider_job
      flash[:notice] = "Search Created Succesfull! A Spider is entring the portals :)"
      redirect_to @search_param.user
    else
      render 'new'
    end
  end 

  def edit
  end

  def update
    if @search_param.update(search_param_params)
      # Flats are not longer representative of that search.
      SearchParamFlat.where({search_param_id: @search_param.id}).destroy_all
      run_and_schedule_spider_job
      flash[:notice] = "Search Updated Succesfully! A Spider is entring the portals :)"
      redirect_to @search_param.user
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

  def run_and_schedule_spider_job
    SpiderJob.perform_later(@search_param.id)
    cron_job = Sidekiq::Cron::Job.new(name: "SpiderJob_SP#{@search_param.id}", 
                                      cron: "#{@search_param.updated_at.min} #{@search_param.updated_at.hour} * * *", 
                                      class: 'SpiderJob', 
                                      args: @search_param.id)
    if cron_job.valid? && !cron_job.exists?
      cron_job.save
    end
  end

  
end