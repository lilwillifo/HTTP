require 'pry'
require './lib/response'
require './lib/hello'
require './lib/datetime'
require './lib/shutdown'
require './lib/wordsearch'
require './lib/game'

class Route
  attr_reader :request, :verb, :path, :hello_count, :total_request, :lines
  def initialize(client, request, lines)
    @client = client
    @request = request
    @lines = lines
    @verb = @lines[0].split[0]
    @path = @lines[0].split[1]
    @hello_count = 0
    check_verb
  end

  def check_verb
    if @verb == 'GET'
      get
    elsif @verb == 'POST'
      post
    end
    @verb
  end

  def get
    @hello_count += 1 if @path == '/hello'
    return                                         if @path.nil?
    return Response.new(@client, @request, @lines)          if @path == '/'
    return Hello.new                               if @path == '/hello'
    return DateTime.new                            if @path == '/datetime'
    return Shutdown.new                            if @path == '/shutdown'
    return WordSearch.new(@path)                   if @path.include? '/wordsearch'
    return Game.new                                if @path == '/game'
  end

  def post
    return if @path.nil?
    return Game.new.start if @path == '/startgame'
  end
end
