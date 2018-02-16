require './lib/response'
require 'pry'

class Game < Response
  attr_reader :body, :lines
  def initialize(client, verb, lines)
    @client = client
    @verb = verb
    @count = 0
    @last_guess = 15
    @number = 15
    parse_request(lines)
    check_verb
  end

  def check_verb
    if @verb == 'GET'
      guess_summary
    end
  end

  def guess_summary
    @body = "You have made #{@count} guesses. Your last guess was "\
            "#{high_low}"
  end

  def high_low
    if @last_guess > @number
      'too high!'
    elsif @last_guess < @number
      'too low!'
    else
      'correct!1!1!!!OMG'
    end
  end

  def take_guess(guess)
    @count += 1
    @last_guess = guess
  end
end
