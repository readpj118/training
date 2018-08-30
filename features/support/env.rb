require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'connection_pool'
require File.dirname(__FILE__) + '/test_config'
require_relative 'test_config'
require 'httparty'
require 'uri'
require 'net/imap'
require 'net/http'
require 'net/https'
require 'capybara/cucumber'
require 'process'
require 'oci8'
require 'active_support/all'
require 'testrail'
require 'mysql2'
require 'graphite-api'
require 'pg'
require 'tiny_tds'
require 'selenium-webdriver'
require 'sauce_whisk'


Before do
  Capybara.run_server = false
  Capybara.default_driver = TestConfig["capybara_default_driver"]
  Capybara.default_max_wait_time = TestConfig["default_timeout"]
  Capybara.app_host = TestConfig["default_site"]
  if TestConfig['headless']
    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {'args' => %w(--start-maximized --disable-infobars --headless)})
  else
    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {'args' => %w(--start-maximized --disable-infobars)})
  end
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome, :desired_capabilities => caps)
  end
end

After do
  Capybara.current_session.driver.quit
end

#Run after each scenario
After do |scenario|
  if scenario.failed?
    dir_path = 'features/screenshots/'
    if Dir.exist?(dir_path)
      Dir.foreach(dir_path) do |f|
        fn = File.join(dir_path, f)
        File.delete(fn) if f != '.' && f != '..'
      end
      p "=========Directory exists at #{dir_path}"
    else
      Dir.mkdir(dir_path, 0777)
      p "=========Directory is created at #{dir_path}"
    end
    time = Time.now.strftime('%d_%m_%YT%H_%M_%S_')
    name_of_scenario = time + "#{scenario.name}"
    p "Name of snapshot is #{name_of_scenario}"
    file_path = File.expand_path(dir_path)+'/'+name_of_scenario +'.png'
    page.driver.browser.save_screenshot file_path
    p 'Snapshot is taken'
    p '#===========================================================#'
    p "Scenario: #{scenario.name}"
  end
end

# module Helpers
#   def without_resynchronize
#     page.driver.options[:resynchronize] = false
#     yield
#     page.driver.options[:resynchronize] = true
#   end
# end

# World(Capybara::DSL, Helpers)

#this is executed at the end
## at_exit do
#   $test_case_id = nil
# end
