
# Given a name, returns "The Name Game" representation of that name.
# See http://www.reddit.com/r/dailyprogrammer/comments/338p28/20150420_challenge_211_easy_the_name_game/
# for full specs.

VOWELS = ["a", "e", "i", "o", "u"]

def name_game(name)
	name.downcase!
	return "Name must contain at least one character!" if name.size <= 0
	return "Only letters please!" if name.gsub(/[^a-zA-Z]/i, '') != name

	name_arr = name.split("")
	if VOWELS.include? name_arr[0].downcase
		name_arr[0].downcase!
	else
		name_arr.shift
	end
	name_ending = name_arr.join

	return construct_output(name.capitalize, name_ending)
end

def construct_output(name, name_ending)
	output = ""
	output += name + ", " + name + " " + consonant_rhyme(name, name_ending, "b") + "\n"
	output += "Bonana fanna " + consonant_rhyme(name, name_ending, "f") + "\n"
	output += "Fee fy " + consonant_rhyme(name, name_ending, "m") + "\n"
	output += name + "!\n"
	return output
end

def consonant_rhyme(name, ending, l)
	return name[0].downcase == l.downcase ? l.upcase + "o-" + ending : l.downcase + "o " + l.upcase + ending 
end

def play_game
	puts "Let's play the name game! Enter your name: "
	name = gets
	puts "-------------------------"
	puts name_game(name.strip)
	puts "-------------------------"
end

play_game
