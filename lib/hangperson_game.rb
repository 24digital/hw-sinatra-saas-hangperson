class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def guess(letter)
    if (letter.nil? or !(letter =~ /^[[:alpha:]]$/))
			raise ArgumentError	
	 end
    letter.downcase!
    if @word.include? letter
      if !@guesses.include? letter
      
        @guesses += letter
        return true
      else
        return false
      end
    else
      if !@wrong_guesses.include? letter.upcase and !@wrong_guesses.include?(letter.downcase)
       @wrong_guesses += letter
      else
        return false
      end
    end
  end
  
  def word_with_guesses
    space = ''
    word.each_char do|i|
			if @guesses.include? i
				space << i
			else
				space << '-'
			end
		end
		return space
  end
  
  def check_win_or_lose
    if wrong_guesses.length >= 7
      return :lose
    end
    
   word.each_char do|i|
			if !@guesses.include? i
				return :play
			end
		end
		return :win
		
  end
 

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
