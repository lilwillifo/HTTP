
require 'socket'

class Server
  attr_reader :tcp_server, :client
  def initialize
    @server = TCPServer.new(9292)
    @request_count = 0
  end

  def start
    client = @server.accept
    get_request(client)
  end

  def get_request(client)
    request = Request.new(client)
    request.save_request
    @request_count += 1
    client.close
  end
end
