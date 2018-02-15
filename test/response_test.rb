require_relative 'test_helper'
require 'Faraday'
require './lib/response'
require 'socket'

# run the runner file in one terminal before running this test
class ResponseTest < Minitest::Test
  def test_it_exists
    response = Response.new('client', 'request', ['a','Host: 127.0.0.1:9292','c','d'])

    assert_instance_of Response, response
    assert response.client == 'client'
    assert response.request == 'request'
    assert_nil response.body
    assert_equal ['a','Host: 127.0.0.1:9292','c','d'], response.lines
  end

  def test_headers_and_footer
    response = Response.new('client', 'request', ['a','Host: 127.0.0.1:9292','c','d'])

    assert_instance_of String, response.headers
    assert_instance_of String, response.footer
  end

  def test_output
    skip
    response = Response.new('client', Request.new('client'))

    assert response.output.include?('<html><head></head>')
  end

end
