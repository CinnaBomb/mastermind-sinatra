 require 'sinatra'
 require 'sinatra/reloader' if development? 
 require './mastermind'

 p = PlayerGame.new
 get '/' do 

 	code = p.code
 	puts code
 	guesses_left = p.max_guess_count - p.guess_count
 	
 	if !params['guess'].nil? 
 		guess = params['guess'].downcase.chomp.split(" ")
 		if p.valid_guess(guess)
 			game_board = p.game_board(guess)
 			game_hints = p.check_guess(guess)
 			if p.game_over?(guess)
 				message = p.game_over_message(guess)
 			end
 		end
 		 error_message = p.error_message
 	end



 	erb :index, :locals => { :game_board => game_board, :game_hints => game_hints, 
 		:guesses_left => guesses_left, :error_message => error_message,
 		:message => message }

 end

 # p = PlayerGame.new
 # p.valid_guess("blue".downcase.chomp.split(" "))
 # puts p.error_message

