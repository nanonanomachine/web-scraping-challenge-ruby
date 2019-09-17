# For development
require "bundler/setup"
Bundler.require

require 'open-uri'

doc = Nokogiri::HTML(open('https://scrapingclub.com/exercise/detail_basic/'))

# Get by CSS
puts "CSS"
puts "title: #{doc.css('.card-title').first.content}"
puts "desc: #{doc.css('.card-text').first.content}"
puts "price: #{doc.css('.card-body h4').first.content}"

puts "---------"

# Get by Xpath
puts "Xpath"
puts "title: #{doc.xpath('//*[@class="card-title"]').first.content}"
puts "desc: #{doc.xpath('//*[@class="card-text"]').first.content}"
puts "price: #{doc.xpath('//*[@class="card-body"]/h4').first.content}"
