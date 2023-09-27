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
    
    board.draw_board
    until @win
      # get error checked move, pass to logic: win? how many color right? how many position right? pass array to board)
      board.moves.push(logic.do_turn(get_current_move))
      system "clear"
      board.draw_board
    end
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
    p current_solution
    p current_move
    @current_move = current_move
    if current_move == current_solution
      @game.win = true
    end
  end

  def how_many_correct_colors(current_move, current_solution)
    total_correct = 0
  
    # Iterate through each element of the current_move array - how many colors are correct? total number pushed to move array
    current_move.each_with_index do |color, index|
      if current_solution.include?(color)
        total_correct += 1

      
      end
    end
    @current_move.push(total_correct)
    
  end
  
  def how_many_correct_positions(current_move, current_solution)
    total_correct = 0
  
    # Iterate through each element of the current_move array - how many positions are correct? total number pushed to move array *******************NOT WORKING****************** incorrect value
    current_move.each_with_index do |color, index|
      if color == current_solution[index]
        total_correct += 1
      end
    end
    @current_move.push(total_correct)
    p @current_move
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