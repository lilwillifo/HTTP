require 'socket'
require_relative 'request'
require_relative 'response'

class Server
  def initialize
    @tcp_server = TCPServer.new(9292)
  end

  def start
    counter = 0
    loop do
      client = @tcp_server.accept
      save_request(client)
      send_response(client)
      counter += 1
    end
    client.close
  end

  def save_request(client)
    @request = Request.new(client)
    @request.save_request
  end

  def send_response(client)
    response = Response.new(client, @request)
    response.send_response
  end

  def response
    '<pre>' + "Hello World!(#{counter})" + '</pre>'
  end

end
