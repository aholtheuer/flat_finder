require_relative '../scrapper/portal_spider.rb'

class SpiderJob < ApplicationJob
  queue_as :default

  def perform(search_param_id)
    @search_param = SearchParam.find(search_param_id)
    
    parsed_hash = PortalSpider.parse!(:parse, 
                                    url: ApplicationController.helpers.search_urls(@search_param)[:portal_inmobiliario],
                                    data: { search_param: @search_param } 
    )
    # save parsed_hash 

    parsed_hash[:flats].each do |flat|
      @flat = Flat.new(flat)
      if @flat.save
        save_search_param_flat(@flat.id)                                       
      end
    end

    parsed_hash[:search_param_flats].each do |flat_id|
      save_search_param_flat(flat_id)
    end

    # Send email only of the new flats
    @search_param_flats = @search_param.search_param_flats.where(emailed_at: nil)
    if @search_param_flats.any?
      SpiderMailer.with(search_param: @search_param).spider_email.deliver_later
    end
  end

  private 

  def save_search_param_flat(flat_id)
    search_param_flat = SearchParamFlat.new(search_param_id: @search_param.id, flat_id: flat_id)
    search_param_flat.save
  end
end
