require_relative 'request'

class Response
  attr_reader :client, :request, :body, :request_count
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
    @request.footer
  end

  def output
    "<html><head></head><body>#{@body}</body>"\
           "<footer>#{footer}</footer></html>"
  end

  def choose_path(request)
    @request_count += 1
    return if request.path.nil?
    root if request.path == '/'
    hello if request.path == '/hello'
    datetime if request.path == '/datetime'
    shutdown if request.path == '/shutdown'
    word_search if request.path.include? '/wordsearch'
  end

  def root
    send_response
  end

  def hello
    @hello_counter += 1
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

  def word_search
    word = @request.path.split('?')[1]
    dictionary = read_dictionary
    @body = if dictionary.include?(word)
              "#{word} is a known word"
            else
              "#{word} ain't a word."
            end
    send_response
  end

  def read_dictionary
    File.readlines('/usr/share/dict/words').map(&:strip)
  end

  def send_response
    @client.puts headers
    @client.puts output
  end
end
