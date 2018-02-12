
require 'socket'

class Server
  attr_reader :tcp_server, :client
  def initialize
    @tcp_server = TCPServer.new(9292)
    @requests = 0
  end

  def start
    client = @server.accept
    get_request(client)
  end

  def get_request(client)
    request = Request.new(client)
    request.save_request
    @requests += 1
    client.close
  end

end
