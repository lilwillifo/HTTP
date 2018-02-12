class Request
  attr_reader :request_lines

  def initialize(client)
    @request_lines = []
    @client = client
  end

  def document_request
    while line = @client.gets && !line.chomp.empty?
      @request_lines << line.chomp
    end
  end


end
