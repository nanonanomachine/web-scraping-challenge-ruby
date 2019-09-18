# For development
require "bundler/setup"
Bundler.require

browser = Watir::Browser.new(:chrome, headless: true)

browser.goto 'https://scrapingclub.com/exercise/basic_login/'
browser.text_field(name: 'name').set('scrapingclub')
browser.text_field(name: 'password').set('scrapingclub')
browser.button(value: 'Log in').click

pp browser.url

browser.close
