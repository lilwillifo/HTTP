require 'Faraday'
require './lib/server'
require_relative 'test_helper'

class ServerTest < Minitest::Test
  def test_hello_returns_expected_body
    response = Faraday.get 'http://127.0.0.1:9292/'
    expect = '<html><head></head><body><pre>Hello World!(0)</pre></body></html>'

    assert_equal expect, response.body

    response = Faraday.get 'http://127.0.0.1:9292/'
    expect = '<html><head></head><body><pre>Hello World!(1)</pre></body></html>'

    assert_equal expect, response.body

    response = Faraday.get 'http://127.0.0.1:9292/'
    expect = '<html><head></head><body><pre>Hello World!(2)</pre></body></html>'

    assert_equal expect, response.body
  end

end
