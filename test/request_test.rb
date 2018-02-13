require 'Faraday'
require './lib/request'
require 'socket'
require_relative 'test_helper'

class RequestTest < Minitest::Test
  def test_it_exists
    request = Request.new('a client here')

    assert_instance_of Request, request
  end

  def test_save_request
    skip
    client = TCPServer.new(9292).accept
    request = Request.new(client)

    assert_equal [], request.request_lines

    request.save_request

    assert_equal 'GET / HTTP/1.1', request.request_lines[0]

    request.parse_request

    assert_equal request.request_lines[0].split[0], request.verb
  end
end
