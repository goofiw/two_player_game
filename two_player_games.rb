require './players'
require 'colorize'



def get_players

  loop do
    puts "What's your name sunny?"
    player_name = gets.chomp
    @players << Player.new(name: player_name)
    if @players.length > 1
      puts "Type yes to add another player"
      additional_player = gets.chomp
      break if additional_player != 'yes' 
    end
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
  @players.each { |player| puts "#{player.name} has won #{player.wins} games" }
  puts "Would you like to play again? (y or n)"
  gets.chomp
end

def reset_lives
  @players.each { |player| player.gain_lives(3) }
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
  get_players
  
  loop do
    players_alive = @players.length
    while players_alive > 1
      @players.each do |player| 
        if player.lives > 0
          problem = create_problem
          puts "#{player.name} " + problem[0]
          if check_answer?(problem[1], get_answer) 
            player.give_point
            puts "Correct ! #{player.name}, you now have #{player.score} points".green
          else
            player.lose_life
            puts "Incorrect response #{player.name}, you're down to #{player.lives} lives".red
          end
          if player.lives == 0
            puts "#{player.name} you are are out of lives and finished with #{player.score} points"
            players_alive -= 1
          end
        end
      end
    end
    @players.each { |player| player.win if player.lives > 0 }
    break if !play_again?
  end
end





  