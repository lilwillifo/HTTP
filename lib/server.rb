require 'socket'
class Server
  def initialize
  @tcp_server = TCPServer.new(9292)
  end

  def start
    counter = 0
    loop do
      client = @tcp_server.accept

      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end

      puts request_lines.inspect
      @verb = request_lines[0].split(" ")[0]
      @path = request_lines[0].split(" ")[1]
      @protocol = request_lines[0].split(" ")[2]
      @host = request_lines[1].split(" ")[1].split(":")[0]
      @origin = request_lines[1].split(" ")[1].split(":")[0]
      @accept =

      response = "<pre>" + "Hello World!(#{counter})" + "</pre>"
      footer = "Verb: #{@verb} Path: #{@path} Protocol: #{@protocol} Host: #{@host} Port: 9292 Origin: #{@origin} Accept: "
      output = "<html><head></head><body>#{response}</body><footer>#{footer}</footer></html>"
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


end
