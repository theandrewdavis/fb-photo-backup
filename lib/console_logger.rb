class ConsoleLogger
  def link_finder_start
    print 'Finding photos...'
  end

  def link_finder_done(number)
    puts " #{number} found."
  end

  def link_finder_invalid_login
    puts ' invalid email or password.'
  end

  def link_finder_no_firefox
    puts ' Firefox could not be found.'
  end

  def link_finder_error
    puts ' error encountered, please try again.'
  end

  def download_progress(done, total)
    print "\rDownloading #{done} of #{total} photos."
    print "\n" if done == total
  end

  def download_errors(errors)
    plural = errors.size > 1 ? 'photos' : 'photo'
    puts "#{errors.size} #{plural} could not be downloaded:"
    errors.each { |link| puts link }
  end
end
