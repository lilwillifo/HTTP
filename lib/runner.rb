require_relative 'server'

class Runner
  attr_reader :server, :requests

  def initialize
    @server = Server.new
    @requests = 0
  end

  def request
    @client = @server.tcp_server.accept
    @client.gets
  end

  def run
    loop do
      request
      break if @requests > 1
      @requests += 1
      response
      @server.client.close
    end
  end

  def response
    output = "Hello, World! (#{@requests})"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @server.client.puts headers
    @server.client.puts output
  end
end
