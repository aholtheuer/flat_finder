require_relative '../scrapper/portal_spider.rb'

class SpiderJob < ApplicationJob
  queue_as :default

  def perform(search_param_hash)
    PortalSpider.parse!(:parse, url: ApplicationController.helpers.search_urls(search_param_hash)[:portal_inmobiliario],
    data: {search_param: search_param_hash})
    #flash[:notice] = "The Spider has finished your search: #{search_param.title}"
  end
end
