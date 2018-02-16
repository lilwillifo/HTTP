require_relative 'test_helper'
require 'Faraday'
require './lib/route'
require 'socket'
require './lib/hello'
require './lib/datepath'
require './lib/shutdown'
require './lib/wordsearch'
require './lib/game'
require './lib/mockclient'

class RouteTest < Minitest::Test
  def test_it_exists
    lines = ['GET / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new(lines)

    assert_instance_of Route, route
  end

  def test_attributes
    lines = ['GET ',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new(lines)

    assert_equal 'GET', route.verb
    assert_equal nil, route.path
    assert_equal lines, route.lines
    assert_equal 0, route.hello_count
  end

  def test_get_root
    lines = ['GET / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new(lines)

    assert_instance_of Response, route.check_path
  end

  def test_get_hello
    lines = ['GET /hello HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new(lines)

    assert_instance_of Hello, route.check_path
  end

  def test_get_date_time
    lines = ['GET /datetime HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new(lines)

    assert_instance_of DatePath, route.check_path
  end

  def test_get_word_search
    lines = ['GET /wordsearch HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new(lines)

    assert_instance_of WordSearch, route.check_path
  end

  def test_get_game
    skip
    lines = ['GET /game HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new(lines)

    assert_instance_of Game, route.get
  end

end
