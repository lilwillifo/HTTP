require 'Faraday'
require './lib/game'
require_relative 'test_helper'

class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end
end
