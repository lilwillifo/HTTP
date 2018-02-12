require 'socket'
class Server
  def initialize
  @tcp_server = TCPServer.new(9292)
  end

  def start
    client = @tcp_server.accept

    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end

    response = "<pre>" + "Hello World (0)" + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output
    client.close
  end

end
