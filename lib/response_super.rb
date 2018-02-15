require_relative 'request'
require_relative 'game'

class ResponseSuper
  def initialize(client, request, body = nil)
    @client = client
    @request = request
    @body = body
  end

  def headers
    ['http/1.1 200 ok',
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     'server: ruby',
     'content-type: text/html; charset=iso-8859-1',
     "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def footer
    ["\r\nVerb: #{@request.verb}",
     "Path: #{@request.path}",
     "Protocol: #{@request.protocol}",
     "Host: #{@request.host}",
     'Port: 9292',
     "Origin: #{@request.origin}",
     "Accept: #{@request.accept}\r\n\r\n"].join("\r\n")
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
