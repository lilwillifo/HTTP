require_relative 'test_helper'
require 'Faraday'
require './lib/route'
require 'socket'
require './lib/hello'
require './lib/datetime'
require './lib/shutdown'
require './lib/wordsearch'
require './lib/game'

class RouteTest < Minitest::Test
  def test_it_exists
    lines = ['GET / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new('client', 'request', lines)

    assert_instance_of Route, route
  end

  def test_attributes
    lines = ['GET / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new('client', 'request', lines)

    assert_equal 'client', route.client
    assert_equal 'request', route.request
    assert_equal 'GET', route.verb
    assert_equal '/', route.path
    assert_equal lines, route.lines
    assert_equal 0, route.hello_count
  end

  def test_check_verb
    lines = ['GET / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new('client', 'request', lines)

    assert_equal 'GET', route.check_verb

    lines = ['POST / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']

    route = Route.new('client', 'request', lines)

    assert_equal 'POST', route.check_verb
  end

  def test_get_root
    lines = ['GET / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new('client', 'request', lines)

    assert_instance_of Response, route.get
  end

  def test_get_hello
    lines = ['GET /hello HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new('client', 'request', lines)

    assert_instance_of Hello, route.get
  end

  def test_get_date_time
    lines = ['GET /datetime HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
   route = Route.new('client', 'request', lines)

   assert_instance_of DateTime, route.get
  end

  def test_get_shutdown
    lines = ['GET /shutdown HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new('client', 'request', lines)

    assert_instance_of Shutdown, route.get
  end

  def test_get_word_search
    lines = ['GET /wordsearch HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new('client', 'request', lines)

    assert_instance_of WordSearch, route.get
  end

  def test_get_game
    lines = ['GET /game HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new('client', 'request', lines)

    assert_instance_of Game, route.get
  end

  def test_post
    lines = ['POST /startgame HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    route = Route.new('client', 'request', lines)

    assert_equal 'Good luck!', route.post
  end
end
