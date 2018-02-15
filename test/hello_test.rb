require_relative 'test_helper'
require 'Faraday'
require 'socket'
require './lib/hello'

class HelloTest < Minitest::Test
  def test_it_exists
    hello = Hello.new(client)

    assert_instance_of Hello, hello
  end

    def test_hello
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

end
