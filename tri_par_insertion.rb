#!/usr/bin/ruby -w

array_of_numbers = ARGV

# my solution
for i in 1...array_of_numbers.length
    j = i-1
    
    while (j >= 0 && array_of_numbers[j] < array_of_numbers[j+1])
        array_of_numbers[j],array_of_numbers[j+1] = array_of_numbers[j+1],array_of_numbers[j]
        j -= 1
    end
end

puts "#{array_of_numbers}"


#     curr = array_of_numbers[i]
#     j = i-1
    
#     while (j >= 0 && array_of_numbers[j] < curr)
#         array_of_numbers[j+1]  = array_of_numbers[j]
#         j -= 1
#         puts "#{j}"
#     end
#     array_of_numbers[j+1] = curr