require 'kimurai'
# require 'kimurai/all'
require 'byebug'

# SlackAppsScraper
class PortalScraper < Kimurai::Base
  @name = 'portal_inmobiliario_spider'
  @driver = :mechanize
  @start_urls = ["https://portalinmobiliario.com/arriendo/departamento/las-condes-metropolitana"]
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    #before_request: { delay: 4..7 }
  }
  def parse(response, url:, data: {})    
    response.css('ol.ui-search-layout li a.ui-search-result__image').each do |flat|
      next unless unique?(:flat_url, flat[:href])
        browser.visit(flat[:href])
        flat_response = browser.current_response
        scraped_flats(flat_response)
    end
  end

  private

  def scraped_flats(response)
    #byebug
    item = {}
    item[:href] = browser.current_url
    item[:name] = response.css('h1.ui-pdp-title')&.text&.squish
    item[:price] = response.css('span.price-tag-amount')&.text.include?('UF') ? response.css('span.price-tag-amount')&.text.sub('$', '//$') : response.css('span.price-tag-amount')&.text.squish
    specs_elements = response.css('div.ui-pdp-highlighted-specs-res__icon-label').first.next_sibling.parent
    item[:specs] =  specs_elements.css('span')&.map(&:text)&.join('//')
    item[:location] = response.css('div.ui-vip-location__subtitle p')&.text.squish
    save_to "scraped_flats_test.json", item, format: :pretty_json, position: false
  end
end

PortalScraper.crawl!