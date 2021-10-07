require 'kimurai'

# Portal Spider
class PortalSpider < Kimurai::Base
  @name = 'portal_inmobiliario_spider'
  @driver = :mechanize
  @start_urls = []
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    retry_request_errors: [{ error: RuntimeError, skip_on_failure: true },
                            {error: "InfiniteRedirectError", skip_on_failure: true}]
  }
  def parse(response, url:, data: {})    
    response.css('ol.ui-search-layout li a.ui-search-result__image').each do |flat|
      next unless unique?(:flat_url, flat[:href])
        byebug
        begin
          href_flat = flat[:href][0..flat[:href].index('#position')-1]
          if Flat.exists?({href: href_flat}) 
            @search_param_flat = SearchParamFlat.new({search_param_id: data[:search_param][:id],
                                                      flat_id: Flat.find_by(href: href_flat)[:id]})
            @search_param_flat.save  
          else
            request_to :parse_flat, url: flat[:href], data: data.merge({href: href_flat})
          end
        rescue
          # do something if cannot load flat page
          next
        end
    end
  end

  def parse_flat(response, url:, data: {})
    byebug
    item = {}
    item[:href] = data[:href]
    item[:name] = response.css('h1.ui-pdp-title')&.text&.squish
    item[:price] = response.css('span.price-tag-amount')&.text.include?('UF') ? response.css('span.price-tag-amount')&.text.sub('$', '//$') : response.css('span.price-tag-amount')&.text.squish
    specs_elements = response.css('div.ui-pdp-highlighted-specs-res__icon-label').first.next_sibling.parent
    item[:specs] =  specs_elements.css('span')&.map(&:text)&.join('//')
    item[:location] = response.css('div.ui-vip-location__subtitle p')&.text.squish
    save_to "scraped_flats_test.json", item, format: :pretty_json, position: false
    @flat = Flat.new(item)
    if @flat.save
      @search_param_flat = SearchParamFlat.new({search_param_id: data[:search_param][:id],
                                                 flat_id: @flat[:id]})
      @search_param_flat.save
    else
      #do something else                                          
    end
  end
end