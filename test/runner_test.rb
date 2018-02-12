require_relative 'test_helper'
require './lib/runner'

class ServerTest < Minitest::Test
  def test_runner_initializes_server
    runner = Runner.new
    runner.run

    assert_instance_of Server, runner.server
    runner.server.tcp_server.close
  end

  def test_runner_counts_requests
    runner = Runner.new
    # uri = URI('http://127.0.0.1:9292')
    assert_equal 0, runner.requests

    runner.run # Change from external request to mock
    # Net::HTTP.get(uri)
    assert_equal 2, runner.requests

    runner.server.tcp_server.close
  end
end
