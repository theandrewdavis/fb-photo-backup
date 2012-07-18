require 'mocha'
require 'yaml'
require 'tmpdir'
require 'selenium-webdriver'

def load_fixtures
  fixture_path = File.join(File.dirname(__FILE__), 'fixtures.yml')
  fixtures = YAML::load_file(fixture_path)
  @good_email = fixtures[:good_login][:email]
  @good_password = fixtures[:good_login][:password]
  @bad_email = fixtures[:bad_login][:email]
  @bad_password = fixtures[:bad_login][:password]
  @raw_link = fixtures[:raw_link]
  @clean_link = fixtures[:clean_link]
  @image_name = fixtures[:image_name]
end
