require_relative 'test_helper'
require 'Faraday'
require 'socket'
require './lib/hello'

class HelloTest < Minitest::Test
  def test_it_exists
    hello = Hello.new('client')

    assert_instance_of Hello, hello
  end
end
