#text hockey
$players = []
$player_location = [1,2,3,1,2,2]
$location_desc = {0 => "behind own net", 1 => "in your defensive zone", 2 => "at center ice", 3 => "in the attacking zone", 4 => "behind CPU's goal"}
$possession = [0,0,0,0,0,0]
$score = [0,0]
$action = [0,4+rand(4)]
$shot_pct = [0, 0.001, 0.01, 0.25, 0.05]
 
def add_players
	until $players.count == 3
		player_count = $players.count.to_s
		player_var = 'p' + player_count
			if $players.count == 0
				puts "Goalie's name?"
			else
				puts "Skater's name?"
			end
		player_var = gets.chomp.capitalize
		$players.push(player_var)
	end
	$players.push("CPU Goalie", "CPU Skater 1", "CPU Skater 2")
	#puts $players.inspect
	puts "Your team: #{$players[0]}, #{$players[1]}, and #{$players[2]}"
end
 
def player_location(player)
	puts "#{$players[player]} is #{$location_desc[$player_location[player]]}"
end

def player_location_change
#if have the puck, move up ice.
#if don't have the puck, move back on defense
end
 
def all_skaters_locations
	#array.each_index { }
	#puts "#{$players[0]} is #{$location_desc[$player_location[0]]}"
	puts "#{$players[1]} is #{$location_desc[$player_location[1]]} and #{$players[2]} is #{$location_desc[$player_location[2]]}"
	#puts "#{$players[3]} is #{$location_desc[$player_location[3]]}"
	puts "#{$players[4]} is #{$location_desc[$player_location[4]]} and #{$players[5]} is #{$location_desc[$player_location[5]]}"
end
 
def possession_who
	if $possession.include?(1) == true
		$possession_player = $possession.index(1)
		puts "#{$players[$possession_player]} has the puck."
			if (0..2) === $possession_player
				$possession_team = 0 #your team has the puck
			else
				$possession_team = 1 #your team doesn't have the puck
			end
		#puts "Team #{$possession_team} has the puck."
	else
		$possession_team = 2 #faceoff
		faceoff
	end
end
 
def faceoff
 	puts "--- FACEOFF ---"
 	rand = rand(0)
 		if rand < 0.5 
 			puts "You won the faceoff."
 			$possession_team = 0
	 			if rand < 0.25 then $possession[1]=1 #which player gets the puck
	 			else $possession[2]=1
	 			end
 		else 
 			puts "You lost the faceoff." 
 			$possession_team = 1
	 			if rand < 0.75 then $possession[3] = 1
	 			else $possession[4] = 1
	 			end
 		end 
 	possession_who
end

def goal(team)
	$score[team] += 1
	puts "You: #{$score[0]}. CPU: #{$score[1]}"
end
 
def add_action
	$action[0] += 1
	#puts $action.inspect
end
 
def offense(offense_choice)
	rand = rand(0)
		if offense_choice == 1 #skate toward goal
			puts "Random skate toward goal value: #{rand}"
		elsif offense_choice == 2 #pass
			puts "Random pass value: #{rand}"
		elsif offense_choice == 3 #shoot
			# if $player_location[3] || $player_location[4] != 3
			# 	puts "Defense not there!"
	 		# end
			puts "Shot %: #{$shot_pct[$player_location[$possession_player]]}"
		elsif offense_choice == 4 #hold
			puts "Random hold value: #{rand}"
		else
			puts "You entered something besides 1, 2, 3, or 4."
		end
end
 
def defense(defensive_choice)
end
 
#Game...
 
add_players
 
while $action[0] < $action[1]
	possession_who
	all_skaters_locations
		if $possession_team == 0
			puts "What would you like #{$players[$possession_player]} to do?"
			puts "Skate toward CPU's goal: 1, Pass: 2, Shoot: 3, Hold: 4"
			offense_choice = gets.chomp.to_i
			offense(offense_choice)
		elsif $possession_team == 1
			puts "You're on defense."
			rand = rand(0)
				if rand < 0.5
					offense(3)
				else 
					offense(2)
				end
		elsif $possession_team == 2
			faceoff
		end
 	add_action
end

puts "end of game"
