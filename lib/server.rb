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
    if @lines[0].split[1] == '/shutdown'
      shutdown
    elsif @lines[0].split[1] == '/game'
      game
    else
      route
    end
  end

  def route
    route = Route.new(@lines)
    path = route.check_path
    @client.puts path.headers
    @client.puts path.output
  end

  def shutdown
    shutdown = Shutdown.new(@tcp_server, @lines)
    @client.puts shutdown.headers
    @client.puts shutdown.output
    @client.close
    shutdown.close
  end

  def game
    verb = @lines[0].split[0]
    game = Game.new(@client, verb, @lines)
    @client.puts game.headers
    @client.puts game.output
  end
end
