#!/usr/bin/ruby -w

small_rectangle = ARGV[0]
big_rectangle = ARGV[1]

file1 = File.open(small_rectangle)
file2 = File.open(big_rectangle)

f1_content = file1.read
f2_content = file2.read

f1_lines = f1_content.split("\n")
f2_lines = f2_content.split("\n")

f1_2d_array = []
f2_2d_array = []

f1_row_size = f1_lines.length
f2_row_size = f2_lines.length
f1_column_size = f1_lines[0].length
f2_column_size = f2_lines[0].length

f1_lines.each { |line|
	f1_2d_array.push(line.split(""))
}

f2_lines.each { |line|
	f2_2d_array.push(line.split(""))
}

for i in 0..(f2_row_size-f1_row_size)
	for j in 0..(f2_column_size-f1_column_size)
		flag = 0
		for k in 0...f1_row_size
			for l in 0...f1_column_size
				if (f2_2d_array[i+k][j+l] != f1_2d_array[k][l])
					flag = 1
					break
				end
			end
		end
		if flag == 0
			x = j
			y = i
			break
		end
	end
	if flag == 0
		print "There is a submatrix from #{small_rectangle} contained into "
		print "#{big_rectangle} at coordinates [#{x+1},#{y+1}]\n"
		break
	end
end

file1.close
file2.close
