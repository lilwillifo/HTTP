require 'Faraday'
require './lib/request'
require './lib/server'
require 'socket'
require './test/test_helper'

class RequestTest < Minitest::Test
  def test_it_exists
    request = Request.new('a client here')

    assert_instance_of Request, request
  end

  def test_attribute
    request = Request.new('client here')

    assert_equal 'client here', request.client
  end

  def test_parse_request
    request = Request.new('client')
    request.parse_request(["GET / HTTP/1.1",
                          "User-Agent: Faraday v0.14.0",
                           "Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
                           "Accept: */*",
                           "Connection: close",
                           "Host: 127.0.0.1:9292"])

    assert_equal 'GET', request.verb
    assert_equal '/', request.path
    assert_equal 'HTTP/1.1', request.protocol
    assert_equal 'Faraday', request.host
    assert_equal 'Faraday', request.origin
    assert_equal '*/*', request.accept
  end
end
