require 'pry'
require './lib/response'
require './lib/hello'
require './lib/datepath'
require './lib/shutdown'
require './lib/wordsearch'
require './lib/game'

class Route
  attr_reader :request, :verb, :path, :hello_count, :total_request, :lines
  def initialize(lines)
    @lines = lines
    @verb = @lines[0].split[0]
    @path = @lines[0].split[1]
    @hello_count = 0
  end

  def check_path
    @hello_count += 1 if @path == '/hello'
    return                                    if @path.nil?
    return Response.new(@lines)               if @path == '/'
    return Hello.new(@hello_count, @lines)    if @path == '/hello'
    return DatePath.new(@lines)               if @path == '/datetime'
    return WordSearch.new(@path, @lines)      if @path.include? '/wordsearch'
  end

end
