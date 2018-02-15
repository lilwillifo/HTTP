require 'socket'
require './lib/request'
require './lib/response'
require './lib/route'
require 'pry'

class Server
  attr_reader :tcp_server, :client
  def initialize
    @tcp_server = TCPServer.new(9292)
  end

  def start
    loop do
      @client = @tcp_server.accept
      request = Request.new(client)
      request.save_request
      route = Route.new(request, request.lines)
    end
    client.close
  end

end
