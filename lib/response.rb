require_relative 'request'
require_relative 'game'

class Response
  attr_reader :client, :request, :body, :request_count
  def initialize(client, request, body = nil)
    @client = client
    @request = request
    @body = body
    @hello_counter = 0
    @request_count = 0
  end

  def root
    send_response
  end

  def datetime
    @body = Time.now.strftime('%r on %A %B %e %Y')
    send_response
  end

  def shutdown
    @body = "Total requests: #{@request_count}"
    send_response
    tcpserver.close
  end

  def word_search
    word = @request.path.split('?')[1]
    dictionary = read_dictionary
    @body = if dictionary.include?(word)
              "#{word} is a known word"
            else
              "#{word} ain't a word."
            end
    send_response
  end

  def read_dictionary
    File.readlines('/usr/share/dict/words').map(&:strip)
  end

  def game
    @body = 'You have taken 3 guesses. Your guesses were: 1(too low!) 100 ' +
            '(too high) and 50(right on!)'
    send_response
  end

  def start_game
    game = Game.new
    @body = 'Good luck!'
    send_response
  end
end
