require 'socket'
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
    elsif @lines[0].split[1] == '/startgame'
      @game = Game.new(@client, @lines[0].split[0], @lines)
      game_start
    elsif @lines[0].split[1].include? '/game'
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
    @game = Game.new(@client, verb, @lines)
    content_length if verb == 'POST'
    # game_redirect(client)
    @client.puts @game.headers
    @client.puts @game.output
  end

  def game_start
    output = 'Good luck!'
    headers = ['http/1.1 301 Redirect',
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               'server: ruby',
               'content-type: text/html; charset=iso-8859-1',
               "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
    @client.puts output
  end

  def content_length
    @request_data = {}
    @lines.map do |line|
      data = line.split(': ', 2)
      @request_data[data[0]] = data[1]
      @length = @request_data['Content-Length'].to_i
    end
    user_guess(@length)
  end

  def user_guess(length)
    guess = @client.read(length).split("\r\n")[3].to_i
    game_redirect
  end

  def game_redirect
    # headers = ['http/1.1 302 Redirect',
    #            'Location: http://127.0.0.1/game',
    #            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    #            'server: ruby',
    #            'content-type: text/html; charset=iso-8859-1\r\n\r\n'].join("\r\n")
    output = 'test'#@game.guess_summary

    @client.puts headers
    @client.puts output
  end
end
