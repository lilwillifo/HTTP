require './lib/response'

class Hello
  def initialize
    @hello_counter = 0
    @body = "<pre> Hello World!(#{@hello_counter}) </pre>"
    @hello_counter += 1
    # send_response
  end
end
