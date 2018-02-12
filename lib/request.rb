require 'pry'

class Request
  attr_reader :request_lines,
              :verb,
              :path,
              :protocol,
              :host,
              :origin,
              :accept

  def initialize(client)
    @request_lines = []
    @client = client
  end

  def save_request
    while (line = @client.gets) && !line.chomp.empty?
      @request_lines << line.chomp
    end
    parse_request
  end

  def parse_request
    @verb = @request_lines[0].split[0]
    @path = @request_lines[0].split[1]
    @protocol = @request_lines[0].split[2]
    @host = @request_lines[1].split[1].split(':')[0]
    @origin = @request_lines[1].split[1].split(':')[0]
    @accept = @request_lines[3].split[1]
  end

end
