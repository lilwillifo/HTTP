class WordSearch
  attr_reader :path, :word
    def initialize(path)
      @path = path
      @word = @path.split('?')[1]
      write_body
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
