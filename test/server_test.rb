require_relative 'test_helper'
require 'Faraday'
require './lib/server'

class ServerTest < Minitest::Test
  def test_diagnostics
    response = Faraday.get 'http://127.0.0.1:9292'
    expect = '<html><head></head><body></body>'\
              "<footer>\r\nVerb: GET\r\nPath: /\r\nProtocol: HTTP/1.1\r\n"\
              "Host: Faraday\r\nPort: 9292\r\nOrigin: Faraday\r\nAccept: */*"\
              "\r\n\r\n</footer></html>"
    assert_equal expect, response.body
  end

  def test_start
    skip
    response = Faraday.get 'http://127.0.0.1:9292'
  end
end
