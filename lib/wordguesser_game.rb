class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    if letter == nil or letter.length != 1 or letter.match?(/[^a-zA-Z]/)
      raise ArgumentError
    end
    letter = letter.downcase
    if @guesses.include?(letter) or @wrong_guesses.include?(letter)
      return false
    end
    letter_in_word = false
    if @word.include?(letter)
      letter_in_word = true
      @guesses << letter
    end
    if not letter_in_word
      @wrong_guesses << letter
    end
  end

  def word_with_guesses
    output = ''
    @word.each_char do |letter|
      if @guesses.include?(letter)
        output << letter
      else
        output << '-'
      end
    end
    output
  end

  def check_win_or_lose
    display_word = self.word_with_guesses
    if not display_word.include?('-')
      return :win
    end
    if @wrong_guesses.length >= 7
      return :lose
    end
    :play
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord.txt')
    Net::HTTP.get(uri)
  end
end
