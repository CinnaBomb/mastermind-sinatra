class PlayerGame
	attr_accessor :guess_count, :max_guess_count

	def initialize
		@colors = ["red", "blue", "yellow", "green", "purple", "orange"]
		@guess_count = 0
		@max_guess_count = 12
		@code = new_code
		@board = ""
		@game_won = true
	end

	def new_code
		code = []
		4.times {code << @colors.sample}
		#@code = ["orange", "red", "green", "red"]
		#puts @code.inspect
		code
	end

	def game_board (guess)
		until @max_guess_count-@guess_count == 0
			@board += guess.inspect
		end
		@board

	end

	def game_over_message
		if game_over? == true
			if @game_won == true
				game_over_message = "You won!"
			else
				game_over_message = "You lost!"
			end
		end
		game_over_message

	end

	def valid_guess(guess)
		
		if guess.length == 4 && guess.all?{|color| @colors.include?(color)}
			@guess_count +=1
			return true
		end
		#puts "Be sure to spell color names correctly and guess all 4 spaces"
		false
	end

	def check_guess(guess)
		if @guess == @code
			hints = "Wow you are smart!"
		elsif @guess.any?{|color| @code.include?(color)}
			hints = code_hints
		else
			hints = "None of your guesses were the right colors"
		end
		hints
	end

	def code_hints
		temp_code = [].replace(@code)
		temp_guess = [].replace(@guess)
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

	# def play
	# 	how_to_play
	# 	new_code
	# 	until game_over?
	# 		player_guess
	# 	end
	# 	#puts "|Game Over!          |"
	# 	#puts "_____________________"
	# end


end

