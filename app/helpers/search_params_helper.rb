#require 'app/models/search_param.rb'
module SearchParamsHelper
  def search_urls(search_param)
    hash = {
      comuna: comuna_url(search_param['comuna']), 
      bedroom: bedroom_url(search_param['bedroom']),
      bath: bath_url(search_param['bath']),
      price: price_url(search_param['price_min'], search_param['price_max']),
    }
    {
      portal_inmobiliario: "https://www.portalinmobiliario.com/arriendo/departamento/#{hash[:comuna][:portal_inmobiliario]}-metropolitana/#{hash[:price][:portal_inmobiliario]}#{hash[:bedroom][:portal_inmobiliario]}#{hash[:bath][:portal_inmobiliario]}",
    }
  end


  private

  def comuna_url(comuna)
    {
      portal_inmobiliario: comuna.downcase.gsub(" ", "-"),
    }
  end

  def bedroom_url(bedroom)
    {
      portal_inmobiliario: bedroom ? "_BEDROOMS_" + bedroom.to_s + "-" + bedroom.to_s : '',
    }
  end
  
  def bath_url(bath)
    {
      portal_inmobiliario: bath ? "_FULL*BATHROOMS_" + bath.to_s + "-" + bath.to_s : '',
    }
  end
  
  def price_url(price_min, price_max)
    {
      portal_inmobiliario: price_min || price_max ? "_PriceRange_" + price_min.to_i.to_s + "CLP-" + price_max.to_i.to_s + "CLP" : '',
    }
  end
end
