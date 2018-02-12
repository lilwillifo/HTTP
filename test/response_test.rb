require 'Faraday'
require './lib/response'
require 'socket'
require_relative 'test_helper'

class ResponseTest < Minitest::Test
  def test_it_exists
    response = Response.new('client', 'request')

    assert_instance_of Response, response
  end
end
