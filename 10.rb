# For development
require "bundler/setup"
Bundler.require

browser = Watir::Browser.new(:chrome, headless: true)

browser.goto 'https://scrapingclub.com/exercise/detail_sign/'
script = <<-EOS
  var token = $.cookie('token');
  var sign = $.md5(token);

  return $.ajax({
    type: "GET",
    url: "/exercise/ajaxdetail_sign/" + "?sign=" + sign,
    async: false}).responseText;
EOS
pp JSON.parse(browser.execute_script(script))

browser.close
