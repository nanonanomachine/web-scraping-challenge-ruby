# For development
require "bundler/setup"
Bundler.require

browser = Watir::Browser.new(:chrome, headless: true)

browser.goto 'https://scrapingclub.com/exercise/detail_header/'
script = <<-EOS
  return $.ajax({
    type: "GET",
    url: "/exercise/ajaxdetail_header/",
    async: false}).responseText;
EOS
pp JSON.parse(browser.execute_script(script))

browser.close

