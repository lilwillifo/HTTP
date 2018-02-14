require 'socket'
require_relative 'request'
require_relative 'response'

class Server
  def initialize
    @tcp_server = TCPServer.new(9292)
  end

  def start
    loop do
      client = @tcp_server.accept
      request = Request.new(client)
      request.save_request
      respond = Response.new(client, request).check_verb
    end
    client.close
  end
end
