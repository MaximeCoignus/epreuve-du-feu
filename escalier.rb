#!/usr/bin/ruby -w

steps_number = ARGV[0].to_i

for i in 1..steps_number
  print " " * (steps_number - i)
  puts "#" * i
end

puts "#{8/3}"