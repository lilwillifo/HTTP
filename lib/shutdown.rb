class Shutdown
  def initialize(server)
    @body = "Total requests: #{@request_count}"
    # send_response
    @server = server
    # @server.close
  end
end
