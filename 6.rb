# For development
require "bundler/setup"
Bundler.require

require 'open-uri'

class CrawlerCSS
  attr_reader :results

  def initialize(url)
    @results = []
    @url = url
  end

  def run
    crawl
  end

  private

  def crawl(index=0)
    count = @results.count
    doc = Nokogiri::HTML(open(URI.join(@url, "?page=#{index}")))
    append(doc)
    @results.uniq!
    if @results.count != count
      crawl(index+1)
    end
  end


  def append(doc)
    doc.css('.col-lg-8 .card-body').each do |elm|
      @results << { title: elm.css('.card-title a').first.content, price: elm.css('h5').first.content }
    end
  end
end

crawler = CrawlerCSS.new('https://scrapingclub.com/exercise/list_infinite_scroll/')
crawler.run
pp crawler.results.uniq

