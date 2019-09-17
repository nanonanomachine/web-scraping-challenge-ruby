# For development
require "bundler/setup"
Bundler.require

browser = Watir::Browser.new(:chrome, headless: true)

browser.goto 'https://scrapingclub.com/exercise/detail_json/'
pp browser.execute_script('return obj')

browser.close


