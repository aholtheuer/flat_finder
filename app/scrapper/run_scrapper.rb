require_relative 'scrapper_template.rb'
require 'byebug'

PortalSpider.parse!(:parse, url: urls)

