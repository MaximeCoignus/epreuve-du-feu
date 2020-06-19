#!/usr/bin/ruby -w

word = ARGV[0]
file = ARGV[1]

file_content = File.open(file)

words = file_content.read
list_of_words = words.split("\n")
word_to_test = word.split("")

result = Array.new()

for k in 0...list_of_words.length
    curr_word = list_of_words[k].split("")
    flag = 0
    if (word_to_test.length == curr_word.length)
        for i in 0...word_to_test.length
            flag = 0
            for j in 0...curr_word.length
                if (word_to_test[i] == curr_word[j])
                    curr_word.delete_at(j)
                    flag = 1
                    break
                end
            end
            break if (flag == 0)
        end
    end
    result.push(list_of_words[k]) if (flag == 1)
end

puts "#{result}"

file_content.close