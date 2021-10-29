module Api
  module V1  
    class SearchParamsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_search_param, except: [:create]
      before_action :user_signed_in?
      before_action :requiere_same_user, except: [:create]

      def destroy
        if @search_param.destroy
          flash.notice = "Search deleted succesfully!"
          render json: { json: 'Search Param was successfully deleted.', user_id: current_user.id}
        else 
          render json: { json: @search_param.errors, status: :unprocessable_entity }
        end
      end

      def create
        byebug
        @search_param = SearchParam.new(search_param_params)
        @search_param.user = current_user
        if @search_param.save
          run_and_schedule_spider_job
          flash[:notice] = "Search Created Succesfull! A Spider is entring the portals :)"
          render json: { json: 'Search Param was successfully deleted.', user_id: current_user.id}
        else
          #Fix this
          render 'new'
        end
      end 

      def update
        if @search_param.update(search_param_params)
          # Flats are not longer representative of that search.
          SearchParamFlat.where({search_param_id: @search_param.id}).destroy_all
          run_and_schedule_spider_job
          flash[:notice] = "Search Updated Succesfully! A Spider is entring the portals :)"
          render json: { json: 'Search Param was successfully deleted.', user_id: current_user.id}
        else
          #Fix this
          render('edit')
        end
      end


      private

      def set_search_param
        @search_param = SearchParam.find(params[:id])
      end

      def search_param_params
        params.permit(:title, :comuna, :bedroom, :bath, :price_min, :price_max)
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
  end
end
