require 'pry'

class Request
  attr_reader :verb,
              :path,
              :protocol,
              :host,
              :origin,
              :accept,
              :client

  def initialize(client)
    @client = client
  end

  def save_request
    lines = []
    while (line = @client.gets) && !line.chomp.empty?
      lines << line.chomp
    end
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

  def footer
    ["\r\nVerb: #{verb}",
     "Path: #{path}",
     "Protocol: #{protocol}",
     "Host: #{host}",
     'Port: 9292',
     "Origin: #{origin}",
     "Accept: #{accept}\r\n\r\n"].join("\r\n")
  end

end
