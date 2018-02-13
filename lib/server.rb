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
      request = save_request(client)
      respond(client, request)
    end
    client.close
  end

  def save_request(client)
    request = Request.new(client)
    request.save_request
    request
  end

  def respond(client, request)
    response = Response.new(client, request)
    response.choose_path(request)
  end
end
