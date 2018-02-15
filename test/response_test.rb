require_relative 'test_helper'
require 'Faraday'
require './lib/response'
require 'socket'

# run the runner file in one terminal before running this test
class ResponseTest < Minitest::Test
  def test_it_exists
    lines = ['a','Host: 127.0.0.1:9292','c','d']
    response = Response.new('client', 'request', lines)

    assert_instance_of Response, response
    assert response.client == 'client'
    assert response.request == 'request'
    assert_nil response.body
    assert_equal lines, response.lines
  end

  def test_headers_and_footer
    lines = ['a', 'Host: 127.0.0.1:9292', 'c', 'd']
    response = Response.new('client', 'request', lines)

    assert_instance_of String, response.headers
    assert_instance_of String, response.footer
  end

  def test_parse_request
    lines = ['GET / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    response = Response.new('client', 'request', lines)
    response.parse_request(lines)

    assert_equal 'GET', response.verb
    assert_equal '/', response.path
    assert_equal 'HTTP/1.1', response.protocol
    assert_equal 'Faraday', response.host
    assert_equal 'Faraday', response.origin
    assert_equal '*/*', response.accept
  end

  def test_output
    lines = ['GET / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    response = Response.new('client', Request.new('client'), lines)

    assert response.output.include?('<html><head></head>')
  end

end
