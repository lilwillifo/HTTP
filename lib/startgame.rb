require './lib/response'

class StartGame < Response
  attr_reader :body

  def initialize(lines, verb)
    @verb = verb
    if @verb == 'POST'
      @body = 'Good luck!'
    else @body = 'Change verb to POST'
    end
    parse_request(lines)
  end

end
