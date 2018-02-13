require 'socket'
require_relative 'request'
require_relative 'response'

class Server
  def initialize
    @tcp_server = TCPServer.new(9292)
    @hello_counter = 0
    @request_count = 0
  end

  def start
    loop do
      client = @tcp_server.accept
      save_request(client)
      choose_path(client)
    end
    client.close
  end

  def save_request(client)
    @request = Request.new(client)
    @request.save_request
  end

  def respond(client, request, body)
    response = Response.new(client, request, body)
    response.send_response
    client.close
  end

  def choose_path(client)
    if @request.path == '/'
      root(client, @request)
    elsif @request.path == '/hello'
      hello(client, @request)
    elsif @request.path == '/datetime'
      datetime(client, @request)
    elsif @request.path == '/shutdown'
      shutdown(client, @request)
    end
  end

  def root(client, request)
    @request_count += 1
    respond(client, request, nil)
  end

  def hello(client, request)
    @request_count += 1
    body = '<pre>' + "Hello World!(#{@hello_counter})" + '</pre>'
    respond(client, request, body)
    @hello_counter += 1
  end

  def datetime(client, request)
    @request_count += 1
    body = Time.now.strftime('%r on %A %B %e %Y')
    respond(client, request, body)
  end

  def shutdown(client, request)
    @request_count += 1
    body = "Total requests: #{@request_count}"
    respond(client, request, body)
  end

end
