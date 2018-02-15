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
    route = Route.new('client', 'request', 'verb', 'path')

    assert_instance_of Route, route
  end

  def test_attributes
    route = Route.new('client', 'request', 'verb', 'path')

    assert_equal 'client', route.client
    assert_equal 'request', route.request
    assert_equal 'verb', route.verb
    assert_equal 'path', route.path
  end

  def test_check_verb
    route = Route.new('client', 'request', 'GET', '/')

    assert_equal 'GET', route.check_verb

    route = Route.new('client', 'request', 'POST', '/')

    assert_equal 'POST', route.check_verb
  end

  def test_get
    route = Route.new('client', 'request', 'GET', '/')

    assert_instance_of Response, route.get

    route = Route.new('client', 'request', 'GET', '/hello')

    assert_instance_of Hello, route.get

    route = Route.new('client', 'request', 'GET', '/datetime')

    assert_instance_of DateTime, route.get

    route = Route.new('client', 'request', 'GET', '/shutdown')

    assert_instance_of Shutdown, route.get

    route = Route.new('client', 'request', 'GET', '/wordsearch')

    assert_instance_of WordSearch, route.get

    route = Route.new('client', 'request', 'GET', '/game')

    assert_instance_of Game, route.get
  end

  def test_post
    route = Route.new('client', 'request', 'POST', '/startgame')

    assert_equal 'Good luck!', route.post
  end
end
