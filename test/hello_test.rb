require_relative 'test_helper'
require 'Faraday'
require 'socket'
require './lib/hello'

class HelloTest < Minitest::Test
  def test_it_exists
    lines = ['GET /hello HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    hello = Hello.new(2, lines)

    assert_instance_of Hello, hello
  end

  def test_attributes
    lines = ['GET /hello HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    hello = Hello.new(2, lines)

    assert_equal 2, hello.hello_counter
    assert_equal '<pre> Hello World!(2) </pre>', hello.body
  end

  def test_parse
    lines = ['GET /hello HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    hello = Hello.new(2, lines)

    assert_equal 'GET', hello.verb
    assert_equal '/hello', hello.path
  end

end
