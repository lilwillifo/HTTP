require './lib/response'
require 'pry'

class Game < Response
  attr_reader :body, :lines
  def initialize(client, verb, lines)
    @client = client
    @verb = verb
    @guesses = []
    @number = 15
    parse_request(lines)
    check_verb
  end

  def check_verb
    if @verb == 'GET'
      guess_summary
    elsif @verb == 'POST'
      take_guess
    end
  end

  def guess_summary
    @body = "You have made #{@guesses.length} guesses."
  end

  def take_guess
  end
end
