require 'pry'
require './lib/response'
require './lib/hello'
require './lib/datetime'
require './lib/shutdown'
require './lib/wordsearch'
require './lib/game'
class Route
  attr_reader :client, :request, :verb, :path
  def initialize(client, request, verb, path)
    @client = client
    @request = request
    @verb = verb
    @path = path
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
    return Response.new(@client, @request) if @path == '/'
    return Hello.new(@client, @request)    if @path == '/hello'
    return DateTime.new                    if @path == '/datetime'
    return Shutdown.new                    if @path == '/shutdown'
    return WordSearch.new(@path)           if @path.include? '/wordsearch'
    return Game.new                        if @path == '/game'
  end

  def post
    return Game.new.start if @path == '/startgame'
  end
end
