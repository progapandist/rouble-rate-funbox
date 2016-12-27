require 'nokogiri'
require 'open-uri'

class CBRateFinder
  def self.dollar
    url = "http://cbr.ru/"
    parsed = Nokogiri::HTML(open(url))
    found = parsed.search('#widget_exchange .w_data_wrap')
    rate_str = found.first.text.gsub(/[^0-9,]+/, '')
    rate_str.gsub(',', '.').to_f
  end
end
