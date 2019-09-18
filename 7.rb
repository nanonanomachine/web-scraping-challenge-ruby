# For development
require "bundler/setup"
Bundler.require

browser = Watir::Browser.new(:chrome, headless: true)

browser.goto 'https://scrapingclub.com/exercise/detail_cookie/'
script = <<-EOS
  var token = $.cookie('token');

  return $.ajax({
    type: "GET",
    url: "/exercise/ajaxdetail_cookie/" + "?token=" + token,
    async: false}).responseText;
EOS
pp JSON.parse(browser.execute_script(script))

browser.close
