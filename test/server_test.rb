require 'Faraday'
require './lib/server'
require_relative 'test_helper'

class ServerTest < Minitest::Test
  def test_hello_returns_expected_body
    skip
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

  def test_diagnostics
    response = Faraday.get 'http://127.0.0.1:9292'
    expect = '<html><head></head><body></body>'\
              "<footer>\r\nVerb: GET\r\nPath: /\r\nProtocol: HTTP/1.1\r\n"\
              "Host: Faraday\r\nPort: 9292\r\nOrigin: Faraday\r\nAccept: */*"\
              "\r\n\r\n</footer></html>"
    assert_equal expect, response.body
  end

  def test_hello
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    expect = '<html><head></head><body><pre>Hello World!(0)</pre></body>'\
              "<footer>\r\nVerb: GET\r\nPath: /hello\r\nProtocol: HTTP/1.1\r\n"\
              "Host: Faraday\r\nPort: 9292\r\nOrigin: Faraday\r\nAccept: */*"\
              "\r\n\r\n</footer></html>"

    assert_equal expect, response.body

    response = Faraday.get 'http://127.0.0.1:9292/hello'
    expect = '<html><head></head><body><pre>Hello World!(1)</pre></body>'\
              "<footer>\r\nVerb: GET\r\nPath: /hello\r\nProtocol: HTTP/1.1\r\n"\
              "Host: Faraday\r\nPort: 9292\r\nOrigin: Faraday\r\nAccept: */*"\
              "\r\n\r\n</footer></html>"

    assert_equal expect, response.body
  end

  def test_datetime
    response = Faraday.get 'http://127.0.0.1:9292/datetime'
    expect = "<html><head></head><body>#{Time.now.strftime('%r on %A %B %e %Y')}</body>"\
              "<footer>\r\nVerb: GET\r\nPath: /datetime\r\nProtocol: HTTP/1.1\r\n"\
              "Host: Faraday\r\nPort: 9292\r\nOrigin: Faraday\r\nAccept: */*"\
              "\r\n\r\n</footer></html>"

    assert_equal expect, response.body
  end

  def test_shutdown
    response = Faraday.get 'http://127.0.0.1:9292/shutdown'
    expect = "<html><head></head><body>Total requests: </body>"\
              "<footer>\r\nVerb: GET\r\nPath: /shutdown\r\nProtocol: HTTP/1.1\r\n"\
              "Host: Faraday\r\nPort: 9292\r\nOrigin: Faraday\r\nAccept: */*"\
              "\r\n\r\n</footer></html>"

    assert_equal expect, response.body
  end
end
