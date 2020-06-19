#!/usr/bin/ruby -w

array_of_words = ARGV[0].split(" ")
index = 0
result = []

for i in 0...array_of_words.length
	array_of_letters = array_of_words[i].split("")
	for j in 0...array_of_letters.length
		if ((/[0-9,'?!]/ =~ array_of_letters[j]) == 0)
			result.push(array_of_letters[j])
			next
		end
		if (index%2 == 0)
			result.push(array_of_letters[j].downcase)
		else
			result.push(array_of_letters[j].upcase)
		end
		index += 1
	end
	result.push(" ")
end

puts "#{result.join("")}"
