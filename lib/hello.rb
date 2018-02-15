require './lib/response'

class Hello < Response
  attr_reader :hello_counter, :body
  def initialize(hello_counter, lines)
    @hello_counter = hello_counter
    @body = "<pre> Hello World!(#{@hello_counter}) </pre>"
    parse_request(lines)
  end
end
