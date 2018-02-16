require 'Faraday'
require './lib/game'
require_relative 'test_helper'

class GameTest < Minitest::Test
  def test_start_game
    response = Faraday.post 'http://127.0.0.1:9292/startgame'
    expect = 'Good luck!'

    assert response.body.include?(expect)
  end

  def test_game
    response = Faraday.get 'http://127.0.0.1:9292/game'
    expect = 'Your last guess was '

    assert response.body.include?(expect)
  end
end
