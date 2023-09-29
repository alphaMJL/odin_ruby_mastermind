

take first color and repeat 4 times
check how many correct colors increased from 0
take this color and keep this number of colors for starting of next answers as [starting colors]

{finding colors}
UNTIL [starting_colors] is full (length = 4) do
start with [starting colors] from last answers, fill next color to try.

add the number of increase for correct colors of selected color to [starting colors]

if increase of correct colors and correct colors+positions are the same, then added colors are in correct positions.

{colors found, random until correct}



def cpu_move
    until board.moves[0..3] == current_solution do
        if board.moves[4] < 4
            return finding_colors
        else
            return finding_random
        end
    end
end

def finding_colors
  puts "One day this will return a move"
end
    
def finding_random
  puts "One day this will return a move"
end









TO BE IMPLEMENTED IN FINDING_COLORS
def cpu_move
    # return array of 4 strings of valid moves
    valid_colors = %w[r b g y o p c m]
    working_colors = valid_colors.dup
    working_answer = [nil, nil, nil, nil]
    definite_color = [nil, nil, nil, nil]
    definite_color_position = [nil, nil, nil, nil]
    previous_board_line = @board.moves #array index0..3 are last moves , 4 correct position, and 5 correct color and position
    #until corrent answer is printed to board
    until previous_board_line[0..3] == @current_solution do
      # while all colors are not yet guessed and there are still valid colors remaining we will try to find the correct colors
      while working_colors.length > 0 && previous_board_line[-1] < 4 do

      definite_answer.each_with_index { |item, index|
        if !nil
          working_answer[index] = item
        end
      }

    end
  

  
    
    move
  end
