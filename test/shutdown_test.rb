require 'Faraday'
require './lib/server'
require_relative 'test_helper'

class ShutdownTest < Minitest::Test
  def test_shutdown
    response = Faraday.get 'http://127.0.0.1:9292/shutdown'
    expect = "<html><head></head><body>Total requests: 1</body>"\
               "<footer>\r\nVerb: GET\r\nPath: /shutdown\r\nProtocol: HTTP/1.1\r\n"\
               "Host: Faraday\r\nPort: 9292\r\nOrigin: Faraday\r\nAccept: */*"\
               "\r\n\r\n</footer></html>"

     assert_equal expect, response.body
  end
end
