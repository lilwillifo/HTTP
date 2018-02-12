require 'Faraday'
require './lib/server'
require_relative 'test_helper'

class ServerTest < Minitest::Test
  def test_start_server_returns_expected_body
    response = Faraday.get 'http://127.0.0.1:9292'
    expected = "<html><head></head><body><footer><pre>\r\nVerb:
                GET\r\nPath: /\r\nProtocol: HTTP/1.1\r\nHost: Faraday\r\nOrigin:
                Faraday\r\n</pre></footer></body></html>"
    assert_equal expected, response.body
  end

  def test_hello_returns_expected_body
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    expected = "<html><head></head><body>Hello, World!(#{@number_of_requests})<footer><pre>\r\nVerb: GET\r\nPath: /hello\r\nProtocol: HTTP/1.1\r\nHost: Faraday\r\nOrigin: Faraday\r\n</pre></footer></body></html>"
    assert_equal expected, response.body
  end

end
