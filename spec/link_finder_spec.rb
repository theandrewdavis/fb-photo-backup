require_relative 'spec_helper'
require_relative '../lib/link_finder'

describe LinkFinder do
  before :all do
    load_fixtures
  end

  it 'should return a photo link from an ajax link' do
    clean = LinkFinder.new(nil).send(:clean_photo_link, @raw_link)
    clean.should eq(@clean_link)
  end

  it 'should fail when an invalid email or password is used' do
    logger = mock(link_finder_start: nil, link_finder_invalid_login: nil)
    links = LinkFinder.new(logger).find_links(@bad_email, @bad_password)
    links.empty?.should eq(true)
  end

  it 'should get links when a valid email and password is used' do
    logger = mock(link_finder_start: nil, link_finder_progress: nil)
    links = LinkFinder.new(logger).find_links(@good_email, @good_password)
    links.size.should eq(200)
    links[0].should eq(@photo_data)
  end

  it 'should show an error if no firefox is found' do
    logger = mock(link_finder_start: nil, link_finder_no_firefox: nil)
    Selenium::WebDriver.stubs(:for).raises(Selenium::WebDriver::Error::WebDriverError)
    links = LinkFinder.new(logger).find_links(@bad_email, @bad_password)
    links.empty?.should eq(true)
  end
end
