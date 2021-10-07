require_relative 'spider.rb'

url = "https://www.portalinmobiliario.com/arriendo/departamento/vitacura-metropolitana/_PriceRange_0CLP-800000CLP_BEDROOMS_2-2"
PortalSpider.parse!(:parse, url: url)

