require 'kimurai'
# require 'kimurai/all'
require 'byebug'

# SlackAppsScraper
class PortalScraper < Kimurai::Base
  @name = 'portal_inmobiliario_spider'
  @driver = :selenium_chrome
  @start_urls = ["https://portalinmobiliario.com/arriendo/departamento/las-condes-metropolitana"]
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    before_request: { delay: 4..7 }
  }
  def parse(response, url:, data: {})
    @base_uri = 'https://www.portalinmobiliario.com'
    #response = browser.current_response
    
    response.css('ol.ui-search-layout li a').each do |flat|
      href = flat.attr('href')
      item = {}
      item[:link] = href
      # browser.visit(href)
      # flat_response = browser.current_response
      # scraped_flats(flat_response)
      save_to "scraped_flats_test.json", item, format: :pretty_json, position: false
    end
  end

  # private

  # def scraped_flats(response)
  #   item = {}
  #   item[:name] = response.css('h1.ui-pdp-title')&.text&.squish
  #   # item[:description] = response.css('#panel_more_info div.p-app_description')&.text&.squish
  #   # categories_element = response.css('p.no_margin:contains("Categories:")').first.next_sibling.parent
  #   # item[:categories] = categories_element.css('a')&.map(&:text)&.join(', ')
  #   save_to "scraped_flats_test.json", item, format: :pretty_json, position: false
  # end
end

PortalScraper.crawl!