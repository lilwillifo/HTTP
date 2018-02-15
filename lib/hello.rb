require './lib/response'

class Hello < Response
  def initialize(hello_counter, lines)
    @hello_counter = hello_counter
    @body = "<pre> Hello World!(#{@hello_counter}) </pre>"
    parse_request(lines)
  end
end
