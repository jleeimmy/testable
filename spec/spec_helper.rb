require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium_chrome
  config.app_host = 'http://takehome.zeachable.com'
end
