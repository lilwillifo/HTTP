require 'Faraday'
require './lib/game'
require_relative 'test_helper'

class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_start_game
    skip
    response = Faraday.post 'http://127.0.0.1:9292/startgame'
    expect = 'Good luck!'

    assert response.body.include?(expect)
  end

  def test_game
    skip
    response = Faraday.game 'http://127.0.0.1:9292/game'
    expect = "hi"

    assert response.body.include?(expect)
  end
end
