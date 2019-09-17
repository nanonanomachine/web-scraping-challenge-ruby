# For development
require "bundler/setup"
Bundler.require

require 'open-uri'

doc = Nokogiri::HTML(open('https://scrapingclub.com/exercise/list_basic/'))

class CrawlerCSS
  attr_reader :results

  def initialize(url)
    @results = []
    @url = url
  end

  def run
    crawl(@url)
  end

  private

  def crawl(url)
    doc = Nokogiri::HTML(open(url))
    append(doc)
    next_page = doc.css('.page-link:contains("Next")')
    crawl(URI.join(@url, next_page.first.attributes["href"].value)) if next_page.count > 0
  end


  def append(doc)
    doc.css('.col-lg-8 .card-body').each do |elm|
      @results << { title: elm.css('.card-title a').first.content, price: elm.css('h5').first.content }
    end
  end
end

class CrawlerXpath
  attr_reader :results

  def initialize(url)
    @results = []
    @url = url
  end

  def run
    crawl(@url)
  end

  private

  def crawl(url)
    doc = Nokogiri::HTML(open(url))
    append(doc)
    next_page = doc.xpath('//*[@class="page-link" and text()="Next"]')
    crawl(URI.join(@url, next_page.first.attributes["href"].value)) if next_page.count > 0
  end


  def append(doc)
    doc.xpath('//*[@class="col-lg-8"]//*[@class="card-body"]').each do |elm|
      @results << {
        title: elm.xpath('h4[@class="card-title"]/a').first.content,
        price: elm.xpath('h5').first.content
      }
    end
  end
end

crawler = CrawlerCSS.new('https://scrapingclub.com/exercise/list_basic/')
crawler.run
pp crawler.results

pp '--------------------'

crawler = CrawlerXpath.new('https://scrapingclub.com/exercise/list_basic/')
crawler.run
pp crawler.results
