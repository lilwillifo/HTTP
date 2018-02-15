require_relative 'test_helper'
require 'Faraday'
require 'socket'
require './lib/datetime'

class DateTimeTest < Minitest::Test
  def test_it_exists
    datetime = DateTime.new

    assert_instance_of DateTime, datetime
  end
end
