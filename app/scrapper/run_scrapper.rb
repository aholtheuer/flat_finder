require_relative 'spider.rb'

url = "https://www.portalinmobiliario.com/arriendo/departamento/las-condes-metropolitana/_PriceRange_800000CLP-0CLP_FULL*BATHROOMS_2-2"
PortalSpider.parse!(:parse, url: url)

