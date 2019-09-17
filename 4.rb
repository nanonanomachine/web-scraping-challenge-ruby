require 'open-uri'
require 'json'

OpenURI.open_uri('https://scrapingclub.com/exercise/ajaxdetail/') do |sio|
  pp JSON.parse(sio.read)
end
