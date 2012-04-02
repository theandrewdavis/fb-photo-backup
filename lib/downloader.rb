require 'open-uri'

class Downloader
  def initialize(logger)
    @logger = logger
  end

  def download(path, links)
    return if links.nil? or links.empty?

    dir = Dir.new(path)
    links.each_with_index do |link, index|
      image_name = link.match(/([^\/]+$)/)[1]
      image_path = File.join(dir, image_name)
      download_photo(link, image_path) unless dir.include?(image_name)
      @logger.download_progress(index + 1, links.size)
    end
    @logger.download_errors(@errors) unless @errors.nil?
  end

  private
  def download_photo(link, path)
    open(link) do |stream|
      File.open(path, 'wb') { |file| file.puts(stream.read) }
    end
  rescue OpenURI::HTTPError
    @errors ||= []
    @errors << link
  end
end
