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
      @lines = save_request
      send_response
      @client.close
    end
  end

  def save_request
    @lines = []
    while (line = @client.gets) && !line.chomp.empty?
      @lines << line.chomp
    end
    @lines
  end

  def send_response
    route = Route.new(@lines)
    path = route.check_verb

    @client.puts path.headers
    @client.puts path.output
  end
end
