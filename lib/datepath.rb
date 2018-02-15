require './lib/response'

class DatePath < Response
  attr_reader :body

  def initialize(lines)
    @body = Time.now.strftime('%r on %A %B %e %Y')
    parse_request(lines)
  end
end
