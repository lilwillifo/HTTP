require 'Faraday'
require './lib/shutdown'
require_relative 'test_helper'

class ShutdownTest < Minitest::Test
  def test_it_exists
    shutdown = Shutdown.new('server')

    assert_instance_of Shutdown, shutdown
  end
  def test_shutdown
    skip
    response = Faraday.get 'http://127.0.0.1:9292/shutdown'
    expect = "<html><head></head><body>Total requests: 1</body>"\
               "<footer>\r\nVerb: GET\r\nPath: /shutdown\r\nProtocol: HTTP/1.1"\
               "\r\nHost: Faraday\r\nPort: 9292\r\nOrigin: Faraday\r\nAccept: "\
               "*/*\r\n\r\n</footer></html>"

     assert_equal expect, response.body
  end
end
