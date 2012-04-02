require 'mocha'
require 'yaml'
require 'tmpdir'
require 'selenium-webdriver'

def load_fixtures
  fixtures = YAML::load_file('fixtures.yml')
  @good_email = fixtures[:good_login][:email]
  @good_password = fixtures[:good_login][:password]
  @bad_email = fixtures[:bad_login][:email]
  @bad_password = fixtures[:bad_login][:password]
  @raw_link = fixtures[:raw_link]
  @clean_link = fixtures[:clean_link]
  @image_name = fixtures[:image_name]
end
