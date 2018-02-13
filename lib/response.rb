require_relative 'request'

class Response
  def initialize(client, request, body = nil)
    @client = client
    @request = request
    @body = body
    @hello_counter = 0
    @request_count = 0
  end

  def headers
    ["http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
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

  def choose_path(request)
    @request_count += 1
    if request.path == '/'
      root
    elsif request.path == '/hello'
      hello
    elsif request.path == '/datetime'
      datetime
    elsif request.path == '/shutdown'
      shutdown
    end
  end

  def root
    send_response
  end

  def hello
    @body = '<pre>' + "Hello World!(#{@hello_counter})" + '</pre>'
    send_response
  end

  def datetime
    @body = Time.now.strftime('%r on %A %B %e %Y')
    send_response
  end

  def shutdown
    @body = "Total requests: #{@request_count}"
    send_response
    tcpserver.close
  end

  def send_response
    @client.puts headers
    @client.puts output
  end
end
