require './test/test_helper'
require 'Faraday'
require './lib/response'
require './lib/request'
require 'socket'
require './lib/MockClient'
require 'Faraday'

# run the runner file in one terminal before running this test
class ResponseTest < Minitest::Test
  def test_it_exists
    lines = ['GET / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    response = Response.new(lines)

    assert_instance_of Response, response
    assert_nil response.body
    assert_equal lines, response.lines
  end

  def test_headers_and_footer
    skip
    lines = ['a', 'Host: 127.0.0.1:9292', 'c', 'd']
    response = Response.new('client', 'request', lines)

    assert_instance_of String, response.headers
    assert_instance_of String, response.footer
  end

  def test_parse_request
    skip
    lines = ['GET / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    response = Response.new('client','request', lines)
    response.parse_request(lines)

    assert_equal 'GET', response.verb
    assert_equal '/', response.path
    assert_equal 'HTTP/1.1', response.protocol
    assert_equal 'Faraday', response.host
    assert_equal 'Faraday', response.origin
    assert_equal '*/*', response.accept
  end

  def test_output
    skip
    lines = ['GET / HTTP/1.1',
             'User-Agent: Faraday v0.14.0',
             'Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
             'Accept: */*',
             'Connection: close',
             'Host: 127.0.0.1:9292']
    response = Response.new(Request.new('client'), lines)

    assert response.output.include?('<html><head></head>')
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
    skip
    response = Faraday.get 'http://127.0.0.1:9292/datetime'
    expect = Time.now.strftime('%r on %A %B %e %Y')

    assert response.body.include?(expect)
  end
end
