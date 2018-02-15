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

  def test_read_dictionary
    response = Response.new('client', 'request')
    assert_equal 235_886, response.read_dictionary.length
  end

  def test_word_search
    response = Faraday.get 'http://127.0.0.1:9292/wordsearch?hi'
    expect = 'hi is a known word'

    assert response.body.include?(expect)
  end
end
