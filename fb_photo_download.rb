require_relative 'lib/link_finder'
require_relative 'lib/downloader'
require_relative 'lib/console_logger'

# Must run LinkFinder for ocra to build properly
if defined?(Ocra)
  puts 'Running a test execution for ocra compilation'
  LinkFinder.new(ConsoleLogger.new).find_links('', '') rescue nil
  abort('Finished test execution')
end

usage = 'Usage: fb_photo_download.exe email password path_to_folder'
abort(usage) if ARGV[0].nil? or ARGV[1].nil? or ARGV[2].nil?

logger = ConsoleLogger.new
links = LinkFinder.new(logger).find_links(ARGV[0], ARGV[1])
Downloader.new(logger).download(ARGV[2], links)
