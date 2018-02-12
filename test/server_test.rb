require 'Faraday'
require './lib/server'
require_relative 'test_helper'

class ServerTest < Minitest::Test
  def test_it_exists
    server = Server.new
    assert_instance_of Server, server
  end

  def test_hello_returns_expected_body
    response = Faraday.get 'http://127.0.0.1:9292/'

    assert_equal 'Hello, World! (0)', response.body
  end

end
