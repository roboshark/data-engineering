# Simple daemon that periodically checks for new Uploads to process.
class UploadDaemon

  # interval - the number of seconds to wait between database checks
  def initialize(interval)
    
    @running = true
    @interval = interval

    trap("INT") do
      @running = false
      Thread.current.wakeup
    end

  end

  def run
    
    puts "=> Starting upload daemon"
    puts "=> Ctrl-C to shutdown daemon"

    while @running

      upload = Upload.next

      if upload.nil?
        sleep(@interval)
      else
        upload.process
      end
      
    end
    
  end

end
