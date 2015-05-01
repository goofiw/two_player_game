require 'colorize'

@players = [
  player_one = {
  	name: "player one",
  	score: 0,
  	lives: 3,
    wins: 0,
  },
  player_two = {
	  name: "player two",
	  score: 0,
	  lives: 3,
    wins: 0,
  },
]
def get_names_from_user
	@players.each do |player|
		puts "#{player[:name]}, what's your name sunny?"
		player[:name] = gets.chomp
	end
end

def create_problem
	num1 = Random.rand(21)
	num2 = Random.rand(21)
  type_randomizer = Random.rand(3)
  if type_randomizer == 0
	  ["What does #{num1} plus #{num2} equal?".blue, num1 + num2]
  elsif type_randomizer == 1
    ["What does #{num1} minus #{num2} equal?".blue, num1 - num2]
  else
    ["What does #{num1} times #{num2} equal?".blue, num1 * num2]
  end
end

def get_answer
	gets.chomp.to_i
end

def check_answer?(answer, response)
	answer == response
end

def play_again_prompt
  @players.each { |player| puts "#{player[:name]} has won #{player[:wins]} games" }
  puts "Would you like to play again? (y or n)"
  gets.chomp
end

def reset_lives
  @players.each { |player| player[:lives] = 3 }
end
  
def play_again?
  response = play_again_prompt
    if response == 'y'
      reset_lives
      return true
    elsif response == 'n'
      return false
    else
      puts "invalid response"
      play_again?
    end
  
end

def play_game
  get_names_from_user
  loop do
    while(@players[0][:lives] > 0 && @players[1][:lives] > 0)
      @players.each do |player| 
      	problem = create_problem
      	puts "#{player[:name]} " + problem[0]
        if check_answer?(problem[1], get_answer) 
          player[:score] += 1 
          puts "Correct ! #{player[:name]}, you now have #{player[:score]} points".green
        else
          player[:lives] -= 1
          puts "Incorrect response #{player[:name]}, you're down to #{player[:lives]} lives".red
        end
      end
    end
    if @players[0][:lives]  == 0
      @players[1][:wins] += 1
     puts "game over, #{@players[1][:name]} wins with #{@players[1][:score]} points!"
    else
      @players[0][:wins] += 1
      puts "game over, #{@players[0][:name]} wins with #{@players[0][:score]} points!"
    end
    break if !play_again?
  end
end

play_game





  