require_relative 'test_helper'
require 'Faraday'
require 'socket'
require './lib/datetime'

class DateTimeTest < Minitest::Test
  def test_it_exists
    datetime = DateTime.new

    assert_instance_of DateTime, datetime
  end


    def test_datetime
      response = Faraday.get 'http://127.0.0.1:9292/datetime'
      expect = Time.now.strftime('%r on %A %B %e %Y')

      assert response.body.include?(expect)
    end

end
