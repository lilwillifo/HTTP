require './lib/response'
require 'pry'

class Game < Response
  attr_reader :body
  def initialize(lines, verb)
    @body = check_verb
    @verb = verb
  end

  def check_verb
    if @verb == 'GET'
    elsif @verb == 'POST'
      guess
    end
  end

  def guess
    'Guessing now!'
  end
end
