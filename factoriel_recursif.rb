#!/usr/bin/ruby -w

number_to_process = ARGV[0].to_i

def recursive(num)
	if num == 1
		return num
	else
		return num * recursive(num - 1)
	end
end

result = recursive(number_to_process)

puts "#{result}"
