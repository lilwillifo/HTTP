require 'socket'
require_relative 'request'
class Server
  def initialize
  @tcp_server = TCPServer.new(9292)
  end

  def start
    counter = 0
    loop do
      client = @tcp_server.accept

      save_request(client)

      response = '<pre>' + "Hello World!(#{counter})" + '</pre>'
      footer = ["\r\nVerb: #{@request.verb}",
                "Path: #{@request.path}",
                "Protocol: #{@request.protocol}",
                "Host: #{@request.host}",
                'Port: 9292',
                "Origin: #{@request.origin}",
                "Accept: \r\n\r\n"].join("\r\n")
      output = "<html><head></head><body>#{response}</body>"\
               "<footer>#{footer}</footer></html>"
      headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].join("\r\n")

      client.puts headers
      client.puts output
      counter += 1
    end
    client.close
  end

  def save_request(client)
    @request = Request.new(client)
    @request.save_request
  end

end
