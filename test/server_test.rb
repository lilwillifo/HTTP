require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'
require_relative 'test_helper'
require 'pry'

# test for server class
class ServerTest < Minitest::Test

  def test_it_exists
    server = Server.new
    assert_instance_of Server, server
  end
end
