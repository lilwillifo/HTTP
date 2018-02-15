require 'pry'
require './lib/route.rb'

class Request
  attr_reader :client, :lines
  def initialize(client)
    @client = client
    @lines = []
  end

  def save_request
    while (line = @client.gets) && !line.chomp.empty?
      @lines << line.chomp
    end
    @lines
  end
end
