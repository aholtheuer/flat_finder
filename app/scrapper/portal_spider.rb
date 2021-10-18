require 'kimurai'

# Portal Spider
class PortalSpider < Kimurai::Base
  #before_action :set_search_param_id

  @name = 'portal_inmobiliario_spider'
  @driver = :mechanize
  @start_urls = []
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    retry_request_errors: [{ error: RuntimeError, skip_on_failure: true },
                            {error: "InfiniteRedirectError", skip_on_failure: true}]
  }
  
  def parse(response, url:, data: {})  
    flats = []
    search_param_flats = []
    @search_param = data[:search_param]
    page = true
    while page
      response.css('ol.ui-search-layout li a.ui-search-result__image').each do |flat|
        next unless unique?(:flat_url, flat[:href])
          begin
            href_flat = flat[:href][0..flat[:href].index('#position')-1]
            @flat = Flat.find_by({href: href_flat})

            #if flat does not exist then scrape flat page
            if !@flat
              flat_item = request_to :parse_flat, url: flat[:href], data: data.merge({href: href_flat})
              flats << flat_item
            # if flat exist in db but is not associeted to search_param then save flat_id
            elsif !@flat.search_params.exists?({id: @search_param['id']})
              search_param_flats << @flat.id
            # else then go to next
            else 
              next
            end
          rescue
            # flat_item{:href} = href_flat
            # flat_item{:name} = "Link caido - no logra parsear"
            puts "No logra parsear"
            next
          end
        end
    #next page
      next_link = response.css('div.ui-search-pagination li.andes-pagination__button--next a[href]')[0]
      if next_link
        browser.visit(next_link[:href])
        response = browser.current_response
      else 
        page = false
      end
    end 
    { flats: flats, search_param_flats: search_param_flats }
  end

  def parse_flat(response, url:, data: {})
    item = {}
    item[:href] = data[:href]
    item[:name] = response.css('h1.ui-pdp-title')&.text&.squish
    item[:price] = response.css('span.price-tag-amount')&.text.include?('UF') ? response.css('span.price-tag-amount')&.text.sub('$', '//$') : response.css('span.price-tag-amount')&.text.squish
    specs_elements = response.css('div.ui-pdp-highlighted-specs-res__icon-label').first.next_sibling.parent
    item[:specs] =  specs_elements.css('span')&.map(&:text)&.join('//')
    item[:location] = response.css('div.ui-vip-location__subtitle p')&.text.squish
    item 
  end
end