require_relative 'request'

class Response
  attr_reader :client, :request, :body, :lines
  def initialize(client, request, body = nil, lines)
    @client = client
    @request = request
    @body = body
    @lines = lines
    parse_request(lines)
  end

  def parse_request(lines)
    @verb = lines[0].split[0]
    @path = lines[0].split[1]
    @protocol = lines[0].split[2]
    @host = lines[1].split[1].split(':')[0]
    @origin = lines[1].split[1].split(':')[0]
    @accept = lines[3].split[1]
  end

  def headers
    ['http/1.1 200 ok',
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     'server: ruby',
     'content-type: text/html; charset=iso-8859-1',
     "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def footer
    ["\r\nVerb: #{@verb}",
     "Path: #{@path}",
     "Protocol: #{@protocol}",
     "Host: #{@host}",
     'Port: 9292',
     "Origin: #{@origin}",
     "Accept: #{@accept}\r\n\r\n"].join("\r\n")
  end

  def output
    "<html><head></head><body>#{@body}</body>"\
           "<footer>#{footer}</footer></html>"
  end

  def send_response
    @client.puts headers
    @client.puts output
  end
end
