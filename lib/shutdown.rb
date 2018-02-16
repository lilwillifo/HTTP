require './lib/response'

class Shutdown < Response
  def initialize(server, lines)
    @body = 'Total requests: 1'
    @server = server
  end

  def close
    @server.close
  end
end
