require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'

# test for server class
class ServerTest < Minitest::Test

  def test_server_responds
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert_equal 'Hello, World! (0)', response.body
  end
end
