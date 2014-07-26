require 'singleton'
require 'open-uri'
require 'nokogiri'
require './models/link'

class TinyletterScraper
  include Singleton
  URL = "http://tinyletter.com/danhon/archive"

  def fetch_html
    Nokogiri::HTML(open(URL))
  end

  def get_links
    html = fetch_html
    html.css('.message-list .message-link').collect {|x| x.attribute("href").value}
  end

  def save_new_links
    get_links.each {|l| Link.find_or_create_by(:url => l)}
  end
end