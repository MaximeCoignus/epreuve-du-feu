#!/usr/bin/ruby -w

file = ARGV[0]
open_file = File.open(file)
raw_file = open_file.read

def get_dimensions(input)
    return [input.split("\n")[0].split(" ")[1].to_i, input.split("\n")[0].split(" ")[0].to_i]
end

def get_start(input)
    return [input.split("\n")[1].split(" ")[1].to_i, input.split("\n")[1].split(" ")[0].to_i]
end

def get_end(input)
    return [input.split("\n")[2].split(" ")[1].to_i, input.split("\n")[2].split(" ")[0].to_i]
end

def get_grid(input)
    grid = []
    rows = input.split("\n")
    for i in 3...rows.length
        row = []
        columns = rows[i].split(" ")
        for j in 0...columns.length
            row.push(columns[j].to_i)
        end
        grid.push(row)
    end
    return grid
end

def format_grid(input, start, stop)
    for i in 0...input.length
        for j in 0...input[i].length
            input[i][j] = "#" if input[i][j] == 1
            input[i][j] = "S" if i == start[0] && j == start[1]
            input[i][j] = "E" if i == stop[0] && j == stop[1]
        end
    end
end

def solve_maze(input, stop)
    i = 0
    list_of_possibility = []
    while (i < input.length)
        j = 0
        while (j < input[i].length)
            list_of_directions = []
            if (list_of_possibility.length == 0)
                if (input[i][j] == "S")
                    for k in 0...input.length
                        for l in 0...input[k].length
                            if k == i+1 && l == j
                                next if input[k][l] == "#" || input[k][l] == "S" || input[k][l] == "E" || input[k][l] == " "
                                list_of_directions << [k,l]
                            end
                            if k == i-1 && l == j
                                next if input[k][l] == "#" || input[k][l] == "S" || input[k][l] == "E" || input[k][l] == " "
                                list_of_directions << [k,l]
                            end
                            if k == i && l == j+1
                                next if input[k][l] == "#" || input[k][l] == "S" || input[k][l] == "E" || input[k][l] == " "
                                list_of_directions << [k,l]
                            end
                            if k == i && l == j-1
                                next if input[k][l] == "#" || input[k][l] == "S" || input[k][l] == "E" || input[k][l] == " "
                                list_of_directions << [k,l]
                            end
                        end
                    end
                    list_of_directions = list_of_directions.shuffle
                    list_of_possibility << list_of_directions[list_of_directions.length-1]
                    input[list_of_possibility[list_of_possibility.length-1][0]][list_of_possibility[list_of_possibility.length-1][1]] = "X"
                end
            elsif (i == list_of_possibility[list_of_possibility.length-1][0] && j == list_of_possibility[list_of_possibility.length-1][1])
                for k in 0...input.length
                    for l in 0...input[k].length
                        if k == i+1 && l == j
                            next if input[k][l] == "#" || input[k][l] == "S" || input[k][l] == " " || input[k][l] == "X"
                            list_of_directions << [k,l]
                        end
                        if k == i-1 && l == j
                            next if input[k][l] == "#" || input[k][l] == "S" || input[k][l] == " " || input[k][l] == "X"
                            list_of_directions << [k,l]
                        end
                        if k == i && l == j+1
                            next if input[k][l] == "#" || input[k][l] == "S" || input[k][l] == " " || input[k][l] == "X"
                            list_of_directions << [k,l]
                        end
                        if k == i && l == j-1
                            next if input[k][l] == "#" || input[k][l] == "S" || input[k][l] == " " || input[k][l] == "X"
                            list_of_directions << [k,l]
                        end
                    end
                end
                list_of_directions = list_of_directions.shuffle
                if (list_of_directions.length > 0)
                    break if list_of_directions.include?(stop)
                    list_of_possibility << list_of_directions[list_of_directions.length-1]
                    input[list_of_possibility[list_of_possibility.length-1][0]][list_of_possibility[list_of_possibility.length-1][1]] = "X"
                    if (list_of_possibility[list_of_possibility.length-2][0] > list_of_possibility[list_of_possibility.length-1][0])
                        i = list_of_directions[list_of_directions.length-1][0]-1
                    end
                    if (list_of_possibility[list_of_possibility.length-2][1] > list_of_possibility[list_of_possibility.length-1][1])
                        j = list_of_directions[list_of_directions.length-1][1]-1
                    end
                else
                    input[i][j] = " "
                    list_of_possibility.pop
                    if (list_of_possibility.length > 1)
                        i = list_of_possibility[list_of_possibility.length-2][0]
                        j = list_of_possibility[list_of_possibility.length-2][1]
                        if (list_of_possibility[list_of_possibility.length-2][0] > list_of_possibility[list_of_possibility.length-1][0])
                            i = list_of_possibility[list_of_possibility.length-1][0]-1
                        end
                        if (list_of_possibility[list_of_possibility.length-2][1] > list_of_possibility[list_of_possibility.length-1][1])
                            j = list_of_possibility[list_of_possibility.length-1][1]-1
                        end
                    else
                        i = 0
                        j = 0
                    end
                end
            end
            j += 1
        end
        break if list_of_directions.include?(stop)
        i += 1
    end
end

def initial_format(input)
    for i in 0...input.length
        for j in 0...input[i].length
            case input[i][j]
            when 0
                input[i][j] = " "
            else
                input[i][j] = input[i][j]
            end
        end
        input[i] = input[i].join("")
    end
    puts "#{input.join("\n")}"
end

# puts "dimensions: #{get_dimensions(raw_file)}"
# puts "start: #{get_start(raw_file)}"
# puts "end: #{get_end(raw_file)}"


grid = get_grid(raw_file)
start = get_start(raw_file)
stop = get_end(raw_file)
format_grid(grid, start, stop)
solve_maze(grid,stop)
initial_format(grid)

open_file.close