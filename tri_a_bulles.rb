#!/usr/bin/ruby -w

array_of_numbers = ARGV

for i in 0...(array_of_numbers.length - 1)
    for j in 0...(array_of_numbers.length - i - 1)
        puts "operation"
        if (array_of_numbers[j].to_i < array_of_numbers[j+1].to_i)
            array_of_numbers[j], array_of_numbers[j+1] = array_of_numbers[j+1], array_of_numbers[j]
            # temp = array_of_numbers[j]
            # array_of_numbers[j] = array_of_numbers[j+1]
            # array_of_numbers[j+1] = temp
        end
    end
end

puts "#{array_of_numbers}"