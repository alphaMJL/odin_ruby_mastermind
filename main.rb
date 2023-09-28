module Input 

  def get_current_move
    valid_colors = %w[r b g y o p c m]
    
    loop do
      puts "Input current move. RBBR = Red, Blue, Blue, Red"
      current_move = gets.chomp.downcase
  
      # Check if the input consists of valid colors and has exactly 4 characters
      if current_move.match?(/^[#{valid_colors.join}]{4}$/)

        return current_move.chars
      else
        puts "Invalid input. Please enter a valid move with 4 characters from: #{valid_colors.join(', ')}"
      end
    end
  end
  

end

class Board
  attr_accessor :moves
  
  def initialize
    @moves = []
  end

  def reset_board
    @moves = []
  end

  def draw_board()
    board = <<-BOARD
    +--------------------------+
    |--------MASTERMIND--------|
    +---+---+---+---+--+---+---+
    | 1 | 2 | 3 | 4 |  | C | P |
    +---+---+---+---+  +---+---+
    BOARD
  
    empty_row = <<-EMPTY
    |   |   |   |   |  |   |   |
    +---+---+---+---+  +---+---+
    EMPTY
  
    # Add empty rows for unused moves
    empty_rows = empty_row * (12 - @moves.length)
    board += empty_rows
  
    # Add moves starting from the bottom and moving upwards
    @moves.reverse_each do |move|
      code_1, code_2, code_3, code_4, correct_colors, correct_positions = move
  
      move_row = <<-MOVE
    | #{code_1.upcase} | #{code_2.upcase} | #{code_3.upcase} | #{code_4.upcase} |  | #{correct_colors} | #{correct_positions} |
    +---+---+---+---+  +---+---+
    MOVE
  
      board += move_row
    end
      
    # Legend for colors and status
    legend = <<-LEGEND
  
    Color Legend:
    R - Red    | B - Blue   | G - Green | Y - Yellow
    O - Orange | P - Purple | C - Cyan  | M - Magenta
  
    Status Legend:
    C - Correct Color   | P - Correct Position
    LEGEND
  
    puts board
    puts legend
  end

  

  def draw_opening
    opening_screen = <<-OPENING



    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    $              MASTERMIND                $
    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

    Welcome to Mastermind where you must guess the secret code in 12 guesses.
    The code will consist of 4 characters representing colors.
    After each guess, you will be shown how many characters are the "Correct Color"
    and how many are also in the "Correct position"

    For example: If the code is RBPG, and you guess GYRG, you will be informed that
    R and G from your guess are in the correct answer "Correct Color = 2" and a G is
    in the correct positions, so "Correct Position = 1"

    This will be shown on the board like this:

    +--------------------------+
    |--------MASTERMIND--------|
    +---+---+---+---+--+---+---+
    | 1 | 2 | 3 | 4 |  | C | P |
    +---+---+---+---+  +---+---+
    |   |   |   |   |  |   |   |
    +---+---+---+---+  +---+---+
    | G | Y | R | G |  | 2 | 1 |  <--- Your guess and the reults
    +---+---+---+---+  +---+---+


    Color Legend:
    R - Red    | B - Blue   | G - Green | Y - Yellow
    O - Orange | P - Purple | C - Cyan  | M - Magenta

    Status Legend:
    C - Correct Color   | P - Correct Position

    Enter 1 to play as the code-breaker.
    Enter 2 to enter a code for the computer to try to solve.
    OPENING

    puts opening_screen
  end
end

class Game
  include Input
  attr_accessor :win
  def initialize
    @win = false
  end

  
  def reset_game
    @win = false
  end
  

  def play(board, logic)
    system "clear"
    board.draw_opening
    
    
    case gets.chomp.to_i #get error checked input from Input
    when 1
      play_as_player(board, logic)
    when 2
      play_as_cpu(board, logic)
    end
  end

  def play_as_player(board, logic)
    system "clear"
    board.draw_board
    until @win
      # get error checked move, pass to logic: win? how many color right? how many position right? pass array to board)
      board.moves.push(logic.do_turn(get_current_move))
      system "clear"
      board.draw_board
    end

  end

  def play_as_cpu
  # game loop for cpu guessing
  end

end




class Game_logic

  def initialize(game)
    @current_solution = []
    #@current_move = []
    @game = game
    create_solution
    p @current_solution
  end

  def reset_game
    create_solution
    @current_move = []
  end
  
  def create_solution
    possible_moves = %w[r b g y o p c m]
    #create random solution
    4.times {@current_solution.push(possible_moves[rand(0..7)])}
  end

  def is_current_move_win(current_move, current_solution)
    @current_move = current_move
    if current_move == current_solution
      @game.win = true
    end
  end

  def how_many_correct_colors(current_move, current_solution)
    total_correct = 0
    # create hash from solution to check against
    count_hash = Hash.new(0)
    current_solution.each { |element| count_hash[element] += 1 }
    #take current_move and look at each element? if element exists in hash and has a value > 1 increase total_correct. minus 1 from hash counter(prevent duplicates)
    current_move.each do |element2|

        if count_hash.key?(element2) && count_hash[element2] > 0
          
          total_correct += 1
          count_hash[element2] -= 1
        end
      end
      # push to the array which will go to board for drawing to console
      @current_move.push(total_correct)
  end
  
  def how_many_correct_positions(current_move, current_solution)
    total_correct = 0
  
    # Iterate through each element of the current_move array - how many positions are correct? total number pushed to move array 
    current_move.each_with_index do |color, index|
      if color == current_solution[index]
        total_correct += 1
      end
    end
    # push to the array which will go to board for drawing to console
    @current_move.push(total_correct)
    
  end

  def update_board_moves
    @board.moves = board.moves.push(@current_move)
  end
  #check if move is correct, build array to return to game loop
  def do_turn(current_move)
    is_current_move_win(current_move, @current_solution)
    how_many_correct_colors(@current_move, @current_solution)
    how_many_correct_positions(@current_move, @current_solution)
    return @current_move
    #update_board_moves
  end

end



board = Board.new
game = Game.new
logic = Game_logic.new(game)
game.play(board, logic)