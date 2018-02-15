require_relative 'test_helper'
require 'Faraday'
require 'socket'
require './lib/wordsearch'

class WordSearchTest < Minitest::Test
  def test_it_exists
    wordsearch = WordSearch.new('wordsearch?hi')

    assert_instance_of WordSearch, wordsearch
  end

  def test_attributes
    wordsearch = WordSearch.new('wordsearch?hi')

    assert_equal 'hi', wordsearch.word
    assert_equal 'wordsearch?hi', wordsearch.path
  end
end
