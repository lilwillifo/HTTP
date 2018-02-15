require './lib/response'

class Shutdown < Response
  def initialize(server, lines)
    @body = 'Total requests: 1'
    @server = server
    parse_request(lines)
  end

  def close
    @server.close
  end
end
