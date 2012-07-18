require 'open-uri'

class Downloader
  def initialize(logger)
    @logger = logger
  end

  def download(path, photos)
    return if photos.nil? or photos.empty?
    dir = Dir.new(path)
    photos.each_with_index do |photo, index|
      image_type = photo[:url].match(/([^\.]+)$/)[1]
      image_name = "#{photo[:id]}.#{image_type}"
      image_path = File.join(dir, image_name)
      download_photo(photo[:url], image_path) unless dir.include?(image_name)
      @logger.download_progress(index + 1, photos.size)
    end
    @logger.download_errors(@errors) unless @errors.nil?
  end

  private
  def download_photo(url, path)
    open(url) do |stream|
      File.open(path, 'wb') { |file| file.puts(stream.read) }
    end
  rescue OpenURI::HTTPError
    @errors ||= []
    @errors << url
  end
end
