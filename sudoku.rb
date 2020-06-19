#!/usr/bin/ruby -w

file = ARGV[0]
open_file = File.open(file)
raw_sudoku_grid = open_file.read

def parse_grid(grid)
    grid_brokedown_into_row = grid.split("\n")
    grid_brokedown_into_row = grid_brokedown_into_row.select do |val|
        val != "---+---+---"
    end

    new_row = []
    puzzle = []

    for i in 0...grid_brokedown_into_row.length
        new_row = []

        grid_brokedown_into_row[i].gsub!("|", "")
        grid_brokedown_into_row[i].gsub!("_", 0.to_s)
        
        splitted_row = grid_brokedown_into_row[i].split("")
        
        for j in 0...splitted_row.length
            new_row.push(splitted_row[j].to_i)
        end

        puzzle.push(new_row)    
    end

    return puzzle
end

def horizontal_scan(puzzle)
    list_of_gaps = []
    flag = 0
    i = 0
    while i < puzzle.length
        j = 0
        while j < puzzle[i].length
            if puzzle[i][j] == 0
                # puts "#{list_of_gaps}"
                # puts "first time: #{i}, #{j}"
                list_of_gaps << [i, j]
                for possibility in puzzle[i][j]+1..9
                    flag = 0
                    puzzle[i][j] = possibility
                    # puts "#{possibility}"
                    for k in 0...puzzle.length
                        for l in 0...puzzle[k].length
                            # puts "general"
                            # puts "#{puzzle[i][j]}"
                            next if (k == i && l == j)
                            if k == i
                                # puts "row"
                                # puts "#{puzzle[k][l]}"
                                if puzzle[k][l] == puzzle[i][j]
                                    flag = 1
                                end
                            end
                            if l == j
                                # puts "column"
                                # puts "#{puzzle[k][l]}"
                                if puzzle[k][l] == puzzle[i][j]
                                    flag = 1
                                end
                            end
                            if (k/3*3 == i/3*3 && l/3*3 == j/3*3)
                                # puts "box"
                                # puts "#{puzzle[k][l]}"
                                if puzzle[k][l] == puzzle[i][j]
                                    flag = 1
                                end
                            end
                            if flag == 1 && puzzle[i][j] == 9
                                flag = 3
                            end
                            break if flag == 1
                        end
                        break if (flag == 1 || flag == 3)
                        flag = 2
                    end
                    next if flag == 1
                    break if flag == 2
                    if flag == 3
                        # puts "[first time] before #{i}, #{j}"
                        puzzle[i][j] = 0
                        list_of_gaps.pop
                        i = list_of_gaps[list_of_gaps.length-2][0]
                        j = list_of_gaps[list_of_gaps.length-2][1]
                        # puts "[first time ]after #{i}, #{j}"
                    end
                end
            elsif puzzle[i][j] != 0 && list_of_gaps.length != 0 && i == list_of_gaps[list_of_gaps.length-1][0] && j == list_of_gaps[list_of_gaps.length-1][1]
                # puts "#{list_of_gaps}"
                # puts "rework: #{i}, #{j}"
                if puzzle[i][j] == 9
                    # puts "[second time] before #{i}, #{j}"
                    puzzle[i][j] = 0
                    list_of_gaps.pop
                    i = list_of_gaps[list_of_gaps.length-2][0]
                    j = list_of_gaps[list_of_gaps.length-2][1]
                    next
                    # puts "[second time] after #{i}, #{j}"
                else
                    for possibility in puzzle[i][j]+1..9
                        flag = 0
                        puzzle[i][j] = possibility
                        # puts "#{possibility}"
                        for k in 0...puzzle.length
                            for l in 0...puzzle[k].length
                                # puts "general"
                                # puts "#{puzzle[i][j]}"
                                next if (k == i && l == j)
                                if k == i
                                    # puts "row"
                                    # puts "#{puzzle[k][l]}"
                                    if puzzle[k][l] == puzzle[i][j]
                                        flag = 1
                                    end
                                end
                                if l == j
                                    # puts "column"
                                    # puts "#{puzzle[k][l]}"
                                    if puzzle[k][l] == puzzle[i][j]
                                        flag = 1
                                    end
                                end
                                if (k/3*3 == i/3*3 && l/3*3 == j/3*3)
                                    # puts "box"
                                    # puts "#{puzzle[k][l]}"
                                    if puzzle[k][l] == puzzle[i][j]
                                        flag = 1
                                    end
                                end
                                if flag == 1 && puzzle[i][j] == 9
                                    flag = 3
                                end
                                break if flag == 1
                            end
                            break if (flag == 1 || flag == 3)
                            flag = 2
                        end
                        next if flag == 1
                        break if flag == 2
                        if flag == 3
                            # puts "[second time] before #{i}, #{j}"
                            puzzle[i][j] = 0
                            list_of_gaps.pop
                            i = list_of_gaps[list_of_gaps.length-2][0]
                            j = list_of_gaps[list_of_gaps.length-2][1]
                            j -= 1 if list_of_gaps.length == 1
                            # puts "[second time] after #{i}, #{j}"
                        end
                    end
                end
            end
            j += 1
        end
        i += 1
    end
end

def back_to_original_shape(puzzle)

    puzzle.each_with_index do |line, idx|
        line.each_with_index do |column, index|
            if (index == 3 || index == 7)
                line.insert(index, "|")
            end
        end
    end

    puzzle.each_with_index do |line, idx|
        if (idx == 3 || idx == 7)
            puzzle.insert(idx, "---+---+---")
        end
    end

    for i in 0...puzzle.length
        if (i != 3 && i != 7)
            puzzle[i] = puzzle[i].join("")
        end
    end
    return puzzle
end

puzzle = parse_grid(raw_sudoku_grid)
horizontal_scan(puzzle)
back_to_original_shape(puzzle)

puts "#{puzzle.join("\n")}"

open_file.close