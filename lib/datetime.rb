class DateTime
  def initialize
    @body = Time.now.strftime('%r on %A %B %e %Y')
    # send_response
  end
end
