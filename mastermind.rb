class PlayerGame
	attr_accessor :guess_count, :max_guess_count, :error_message, :code

	def initialize
		@colors = ["red", "blue", "yellow", "green", "purple", "orange"]
		@guess_count = 0
		@max_guess_count = 2
		@code = new_code
		@board = ""
		@game_won = true
		@error_message = ""
	end

	def new_code
		code = []
		4.times {code << @colors.sample}
		code
	end

	def game_board (guess)
		if @max_guess_count-@guess_count != 0
			line = ""
			guess.each do |color|
				line += "<span style = 'color: #{color}'> ⚫ </span>"
			#@board << guess
			end
			line += "</br>"
			@board += line
		end
		@board

	end

	def game_over_message(guess)
		if game_over?(guess) == true
			if @game_won == true
				message = "You won!"
			else
				message = "You lost!"
			end
		end
		message

	end

	def valid_guess(guess)
		if game_over?(guess) == true
			@error_message = "You've already lost!"
			return false
		end
		
		if guess.length == 4 && guess.all?{|color| @colors.include?(color)}
			@guess_count +=1
			@error_message = ""
			return true
		end
		@error_message = "Be sure to spell color names correctly and guess all 4 spaces"
		false
	end

	def check_guess(guess)
		if guess == @code
			hints = "Wow you are smart!"
		elsif guess.any?{|color| @code.include?(color)}
			hints = code_hints(guess)
		else
			hints = "None of your guesses were the right colors"
		end
		hints
	end

	def code_hints(guess)
		temp_code = [].replace(@code)
		temp_guess = [].replace(guess)
		correct_color_and_position = 0
		correct_color_wrong_position = 0
		#CHECK FOR CORRECT COLORS IN CORRECT POSITIONS
		for i in 0...temp_guess.length
			if temp_guess[i] == temp_code[i]
				correct_color_and_position +=1
				temp_code[i] = "code"
				temp_guess[i] = "guess"
			end
		end
		#CHECK FOR CORRECT COLORS IN WRONG POSITIONS
		for i in 0...temp_guess.length
			if temp_code.include?(temp_guess[i])
				correct_color_wrong_position +=1
			end
		end
		hints = %Q(You have #{correct_color_and_position} colors in their correct positions.
		You have #{correct_color_wrong_position} correct colors in the wrong positions.)

	end

	def game_over?(guess)
		if guess == @code
			@game_won = true
			return true
		elsif @guess_count >= @max_guess_count
			@game_won = false
			return true
		else
			false
		end
	end

end

