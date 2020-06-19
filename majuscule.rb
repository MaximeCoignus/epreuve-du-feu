#!/usr/bin/ruby -w

array_of_words = ARGV[0].split(" ")
last_letter_upcase = true
array_for_altered_words = []

array_of_words.each do |word|
	#Process each word without blank space
	array_of_letters = word.split("")
	array_for_altered_letters = []
	
	array_of_letters.each do |letter|
		if last_letter_upcase
			letter.downcase!
			last_letter_upcase = false
		else
			letter.upcase!
			last_letter_upcase = true
		end
		array_for_altered_letters.push(letter)
	end

	#Each altered letter joined into word to fill in the newly created words array
	array_for_altered_words.push(array_for_altered_letters.join(""))

	#Flag last letter as upcase or downcase so we know what first letter of next word has to be
	if ((array_of_letters.length - 1) % 2 == 0)
                last_letter_upcase = false
        else
                last_letter_upcase = true
        end
end

puts array_for_altered_words.join(" ")
