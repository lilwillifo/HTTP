require 'Faraday'
require './lib/shutdown'
require_relative 'test_helper'

class ShutdownTest < Minitest::Test
  def test_it_exists
    lines = ['GET /shutdown HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    shutdown = Shutdown.new('server', lines)

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
