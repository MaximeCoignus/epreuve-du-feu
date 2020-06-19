#!/usr/bin/ruby -w

array_of_numbers = ARGV

# my solution
for i in 0...array_of_numbers.length
    greatestVal = array_of_numbers[i]
    for j in i+1...array_of_numbers.length
        if (array_of_numbers[j].to_i > greatestVal.to_i)
            greatestVal = array_of_numbers[j]
            array_of_numbers[j], array_of_numbers[i] = array_of_numbers[i], array_of_numbers[j]
        end
    end
end

puts "#{array_of_numbers}"

# solution from internet
# for i in 0...array_of_numbers.length
#     idxOfMax = i
#     for j in (i+1)...array_of_numbers.length
#         if (array_of_numbers[j].to_i > array_of_numbers[idxOfMax].to_i)
#             idxOfMax = j
#         end
#     end
#     if idxOfMax != i
#         array_of_numbers[idxOfMax], array_of_numbers[i] = array_of_numbers[i], array_of_numbers[idxOfMax]
#         temp = array_of_numbers[idxOfMax]
#         array_of_numbers[idxOfMax] = array_of_numbers[i]
#         array_of_numbers[i] = temp
#     end
# end