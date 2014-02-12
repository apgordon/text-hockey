p = 0 #possession
pc = 0 #possession changes
score = 0
score_cpu = 0
pc_cap = 6 + rand(3) #possession change cap
sf = 0 #shot factor

#puts "Possession changes this game: #{pc_cap}"
puts "Welcome to Andrew's Retro Hockey Game"
#puts "sf is #{sf}"
print "Whenever there's a pause, press Enter to continue."
gets.chomp

while pc != pc_cap
if p == 0 #faceoff
print " "
puts "--FACEOFF--"
p = 1 + rand(2)
	if p == 1
	puts "You won the faceoff and control the puck."
	gets.chomp
	else
	puts "You lost the faceoff and are now on defense."
	gets.chomp
	end
end
if p == 1 #offense
print "Pass (1) or Shoot (2): "
input = gets.chomp.to_i
	if input == 1 #chomp
		rand = rand(0)
			if rand >0.3 #pass
				sf += 0.05
				puts "You completed the pass. Your shooting % increased slightly."
			else
				puts "Incomplete pass. CPU collects the puck and starts up the ice."
				gets.chomp
				sf = 0
				p = 2
				pc += 1
			end #pass
	elsif input == 2
		rand = rand(0)+sf
		puts "You take a shot..."
			if rand >0.6 #shot
				puts "GOAL!"
				score += 1
				puts "You: #{score} CPU: #{score_cpu}"
				p = 0
				pc += 1
				gets.chomp
			else
				puts "Blocked by the goalie."
				rand = rand(0) 
				puts "Scramble for the loose puck..."
					if rand > 0.65 #scramble
						puts "You got the puck back!"
						sf = sf/2
					else 
						puts "CPU gathers the puck and starts up the ice."
						p = 2
						pc += 1
						sf = 0
						gets.chomp
					end #scramble
			end #shot
	else
		puts "Input not understood. 1 or 2?"
	end #chomp
end #offense

if p == 2 #defense
rand = rand(0) 
	if rand <0.5 #pass or shoot
		rand = rand(0)
			if rand >0.3 #pass result
				sf += 0.05
				puts "CPU completes a pass..."
				gets.chomp
			else
				puts "CPU attempts a pass, but turns the puck over. You start up the ice."
				gets.chomp
				sf = 0
				#puts "sf = #{sf}"
				p = 1
				pc += 1
			end #pass result
	else 
	puts "CPU takes a shot..."
	gets.chomp
	rand = rand(0)+sf
		if rand >0.6 #shot result
			puts "GOAL!"
			score_cpu += 1
			puts "You: #{score} CPU: #{score_cpu}"
			p = 0
			pc += 1
			sf = 0
			gets.chomp
		else
			puts "Blocked by your goalie."
			sf = sf/2
			rand = rand(0) 
			puts "Scramble for the loose puck..."
				if rand > 0.65 #scramble
					puts "CPU has the puck back!"
				else 
					puts "You gather the puck and start up the ice."
					p = 1
					pc += 1
					gets.chomp
				end #scramble
		end #shot result
	end #pass or shoot
	end #defense
end #entire while

if pc == pc_cap #gameover
puts "... And the final horn sounds. That's the end of the game, folks!"
puts "You: #{score} CPU: #{score_cpu}"
print " "
end