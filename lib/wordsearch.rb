require './lib/response'

class WordSearch < Response
  attr_reader :path, :word
  def initialize(path, lines)
    @path = path
    @word = @path.split('?')[1]
    write_body
    parse_request(lines)
  end

  def write_body
    dictionary = read_dictionary
    @body = if dictionary.include?(@word)
              "#{@word} is a known word"
            else
              "#{@word} ain't a word."
            end
  end

  def read_dictionary
    File.readlines('/usr/share/dict/words').map(&:strip)
  end
end
