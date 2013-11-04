class Wordwrap
  def initialize(wrap_length)
    if !wrap_length.class.ancestors.find { |ancestor| ancestor == Integer }
      raise "Wordwrap must be initialized with an integer"
    end
    @wrap_length = wrap_length
  end

  def wrap(words)
    if (words.class != String)
      raise "wrap must be called with a string parameter"
    end

    @words = words.split(/\s+/)

    if (!@words.any? || @words.first.length < @wrap_length)
      @wrapped_string = @words.shift
      @wrapped_string ||= ""
      character_count = @wrapped_string.length
    else
      @wrapped_string = String.new()
      character_count = wrap_word(@words.shift, 0)
    end

    @words.each do |word|
      puts "character_count: #{character_count}"
      puts "word length: #{word.length}"

      if (word.length > @wrap_length)
        character_count = wrap_word(word, character_count)
      elsif ((word.length + 1 + character_count) < @wrap_length)
        @wrapped_string << " " << word
        character_count += word.length
      else
        @wrapped_string << "\n" << word
        character_count = 0
      end
    end

    if (@wrapped_string[-1,1] == "\n")
      @wrapped_string.chomp!
    end

    @wrapped_string
  end

  private
  def wrap_word(string, character_count)
    split_word = string.split("")
    split_word.each do |character|
      if ((character_count + 1) < @wrap_length)
        @wrapped_string << character
        character_count += 1
      else
        @wrapped_string << character << "\n"
        character_count = 0
      end
    end
    @wrapped_string << "\n"
    character_count = 0
  end
end
