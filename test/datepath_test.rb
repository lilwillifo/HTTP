require_relative 'test_helper'
require 'Faraday'
require 'socket'
require './lib/datepath'

class DatePathTest < Minitest::Test
  def test_it_exists
    lines = ['GET / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    datetime = DatePath.new(lines)

    assert_instance_of DatePath, datetime
    assert_equal Time.now.strftime('%r on %A %B %e %Y'), datetime.body
  end


end
