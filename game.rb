require 'sinatra'
#require 'sinatra/reloader'
require './mastermind'
background = "background: yellow"
p = PlayerGame.new

get '/' do 

	if !params['guess'].nil? && valid_guess(params['guess'])
		guess = params['guess'].downcase.chomp.split(" ")
		game_board = p.game_board(guess)
		game_hints = p.check_guess(guess)
		guesses_left = p.max_guess_count - p.guess_count
		if p.game_over?
			game_over_message = p.game_over_message
		end
	end
	

	erb :index, :locals => { :game_board => game_board, :game_hints => game_hints 
		:background => background, :guesses_left => guesses_left,
		:game_over_message => game_over_message}
	end







