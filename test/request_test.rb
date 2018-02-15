require_relative 'test_helper'
require 'Faraday'
require './lib/request'
require './lib/server'
require 'socket'

#runner file not required, but this will still work if its on
class RequestTest < Minitest::Test
  def test_it_exists
    request = Request.new('a client here')

    assert_instance_of Request, request
  end

  def test_attribute
    request = Request.new('client here')

    assert_equal 'client here', request.client
  end

  def test_save_request
    skip
    server = Server.new
    request = Request.new(server.tcp_server.accept)

    assert_equal [], request.lines
  end

end
