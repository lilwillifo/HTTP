require './lib/response'
require 'pry'

class Game < Response
  attr_reader :body, :lines
  def initialize(client, verb, lines)
    @client = client
    @verb = verb
    @guesses = []
    @last_guess = 15
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
    @body = "You have made #{@guesses.length} guesses. Your last guess was "\
            "#{over_under}"
  end

  def over_under
    if @last_guess > @number
      'too high!'
    elsif @last_guess < @number
      'too low!'
    else
      'correct!1!1!!!OMG'
    end
  end

  def take_guess(guess)
    @body = "#{guess}"
  end
end
