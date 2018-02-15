require 'socket'
require './lib/request'
require './lib/response'
require './lib/route'

class Server
  def initialize
    @tcp_server = TCPServer.new(9292)
  end

  def start
    loop do
      client = @tcp_server.accept
      request = Request.new(client)
      route = Route.new(client, request, request.verb, request.path)
    end
    client.close
  end
end
