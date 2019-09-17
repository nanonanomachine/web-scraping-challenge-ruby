require 'open-uri'
require 'json'

open('https://scrapingclub.com/exercise/ajaxdetail/') do |sio|
  pp JSON.parse(sio.read)
end
