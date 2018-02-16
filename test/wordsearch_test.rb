require_relative 'test_helper'
require 'Faraday'
require 'socket'
require './lib/wordsearch'

class WordSearchTest < Minitest::Test
  def test_it_exists
    lines = ['GET /wordsearch?hi HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    wordsearch = WordSearch.new('/wordsearch?hi', lines)

    assert_instance_of WordSearch, wordsearch
  end

  def test_attributes
    lines = ['GET /wordsearch?hi HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    wordsearch = WordSearch.new('/wordsearch?hi', lines)

    assert_equal 'hi', wordsearch.word
    assert_equal '/wordsearch?hi', wordsearch.path
  end

  def test_read_dictionary
    skip
    response = Response.new('client', 'request')
    assert_equal 235_886, response.read_dictionary.length
  end

  def test_word_search
    skip
    response = Faraday.get 'http://127.0.0.1:9292/wordsearch?hi'
    expect = 'hi is a known word'

    assert response.body.include?(expect)
  end
end
