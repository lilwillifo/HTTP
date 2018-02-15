require_relative 'test_helper'
require 'Faraday'
require './lib/response'
require 'socket'

# run the runner file in one terminal before running this test
class ResponseTest < Minitest::Test
  def test_it_exists
    response = Response.new('client', 'request')

    assert_instance_of Response, response
    assert response.client == 'client'
    assert response.request == 'request'
    assert_nil response.body
  end

  def test_headers_and_footer
    response = Response.new('client', Request.new('client'))

    assert_instance_of String, response.headers
    assert_instance_of String, response.footer
  end

  def test_output
    response = Response.new('client', Request.new('client'))

    assert response.output.include?('<html><head></head>')
  end

  def test_choose_path_get
    request = Request.new('client')
    response = Response.new('client', request)
    response.choose_path_get

    assert_nil request.path
  end

  def test_hello
    skip
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    expect = '<html><head></head><body><pre>Hello World!(0)</pre></body>'\
              "<footer>\r\nVerb: GET\r\nPath: /hello\r\nProtocol: HTTP/1.1\r\n"\
              "Host: Faraday\r\nPort: 9292\r\nOrigin: Faraday\r\nAccept: */*"\
              "\r\n\r\n</footer></html>"

    assert_equal expect, response.body

    response = Faraday.get 'http://127.0.0.1:9292/hello'
    expect = 'Hello World!(1)'

    assert response.body.include?(expect)
  end

  def test_datetime
    response = Faraday.get 'http://127.0.0.1:9292/datetime'
    expect = Time.now.strftime('%r on %A %B %e %Y')

    assert response.body.include?(expect)
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

  def test_start_game
    response = Faraday.post 'http://127.0.0.1:9292/startgame'
    expect = 'Good luck!'

    assert response.body.include?(expect)
  end

  def test_game
    response = Faraday.game 'http://127.0.0.1:9292/game'
    expect = "hi"

    assert response.body.include?(expect)
  end
end
