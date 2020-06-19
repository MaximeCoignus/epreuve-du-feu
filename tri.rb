#!/usr/bin/ruby -w

array_of_numbers = ARGV
new_array = []

while array_of_numbers.length > 0
	new_array.push(array_of_numbers.max{ |a, b| a.to_i <=> b.to_i })
	max_value_index = array_of_numbers.index(array_of_numbers.max{ |a, b| a.to_i <=> b.to_i })
	array_of_numbers.delete_at(max_value_index)
end

puts new_array.join(" ")
