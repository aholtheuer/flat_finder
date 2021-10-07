#require 'app/models/search_param.rb'
require 'byebug'

module SearchParamsHelper
  def search_urls(search_param)
    # hash = {
    #   comuna: comuna_url(search_param[:comuna]), 
    #   bedroom: bedroom_url(search_param[:bedroom]),
    #   price: price_url(search_param[:price]),
    #   bath: bath_url(search_param[:bath]),
    # }
    
    hash = {
      comuna: comuna_url(search_param.comuna), 
      bedroom: bedroom_url(search_param.bedroom),
      price: price_url(search_param.price),
      bath: bath_url(search_param.bath),
  }
  [
    "https://www.portalinmobiliario.com/arriendo/departamento/#{hash[:comuna][:portal_inmobiliario]}-metropolitana/#{hash[:price][:portal_inmobiliario]}#{hash[:bedroom][:portal_inmobiliario]}#{hash[:bath][:portal_inmobiliario]}"
  ]

  end


  private

  def comuna_url(comuna)
    {
      portal_inmobiliario: comuna.downcase.gsub(" ", "-"),
    }
  end

  def bedroom_url(bedroom)
    {
      portal_inmobiliario: "_BEDROOMS_" + bedroom.to_s + "-" + bedroom.to_s,
    }
  end

  def price_url(price)
    {
      portal_inmobiliario: "_PriceRange_" + price[:price_min].to_s + "CLP-" + price[:price_max].to_s + "CLP",
    }
  end

  def bath_url(bath)
    {
      portal_inmobiliario: "_FULL*BATHROOMS_" + bath.to_s + "-" + bath.to_s,
    }
  end
  
end

# hash = {
#   comuna: comuna_url(search_param[:comuna]), 
#   bedroom: bedroom_url(search_param[:bedroom]),
#   price: price_url(search_param[:price]),
#   bath: bath_url(search_param[:bath]),
# }