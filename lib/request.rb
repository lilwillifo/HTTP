require 'pry'
require './lib/route.rb'

class Request
  attr_reader :client, :lines
  def initialize(client)
    @client = client
    @lines = []
  end

end
