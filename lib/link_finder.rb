require 'selenium-webdriver'
require 'cgi'

class LinkFinder
  include Selenium::WebDriver

  def initialize(logger)
    @logger = logger
  end

  def find_links(email, password)
    @logger.link_finder_start
    login(email, password) rescue return []

    # Go to profile page and choose the photos app
    @driver.find_element(:css, '#pagelet_welcome_box a').click
    Wait.new.until { @driver.find_element(:css, '#navItem_photos a') }.click

    # puts total_photos

    # Scroll until all the photos are loaded and return their links
    photos = []
    total = @driver.find_element(:css, '#navItem_photos .countValue').text.to_i
    loop do
      scroll
      photos = photos | find_photos
      break if photos.size >= total
    end
    @logger.link_finder_done(photos.size)
    return photos

  rescue Error::TimeOutError
    @logger.link_finder_error
    return []
  ensure
    # @driver.quit unless @driver.nil?
  end

  private
  def login(email, password)
    @driver = Selenium::WebDriver.for(:firefox)
    @driver.get('https://facebook.com')
    form = @driver.find_element(:id, 'login_form')
    form.find_element(:css, 'input[name="email"]').send_keys(email)
    form.find_element(:css, 'input[name="pass"]').send_keys(password)
    form.submit
    if @driver.current_url.include?('facebook.com/login.php')
      @logger.link_finder_invalid_login
      raise 'Failed login'
    end
  rescue Error::WebDriverError => error
    @logger.link_finder_no_firefox
    raise error
  end

  def scroll
    @driver.execute_script('window.scrollTo(0, document.body.scrollHeight)')
  end
  
  def find_photos
    photos = @driver.find_elements(:css, '#pagelet_photos_of_me a.uiMediaThumb')
    puts "Found #{photos.size} photos"
    photos.map { |photo| clean_photo_link(photo['ajaxify']) }
  end
  
  def loading?
    @driver.find_elements('#pagelet_photos_of_me .uiSimpleScrollingLoadingIndicator').size > 0
  end
  
  def scroll_down
    loop do
      begin
        old = footer.location.y
        @driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
        Wait.new.until { footer.location.y > old }
      rescue Error::TimeOutError
        break
      end
    end
  end

  def footer
    @driver.find_element(:id, 'footerContainer')
  end

  def clean_photo_link(link)
    CGI.unescape(link.match(/src=([^&]+)/)[1])
  end
end
