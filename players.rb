

class Player
	def initialize(name: name) 
	  @name = name
	  @score = 0
	  @lives = 3
	  @wins = 0
	end
	attr_accessor :name
	attr_reader :lives, :wins, :score

	def gain_lives(num_lives)
		@lives = 3
	end

	def lose_life
		@lives -= 1
	end

	def win
		@wins += 1
	end

	def give_point
		@score += 1
	end
end