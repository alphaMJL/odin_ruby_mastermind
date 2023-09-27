class Board
  attr_accessor :moves
  #contains placeholders. Will initialize to empty array.
  @moves = [
    ['X', 'O', 'Y', 'G', 2, 1],
    ['R', 'B', 'G', 'Y', 0, 0],
    # Add more moves here...
  ]

  def reset_board
    @moves = []
  end

  def draw_board(moves)
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
    empty_rows = empty_row * (12 - moves.length)
    board += empty_rows
  
    # Add moves starting from the bottom and moving upwards
    moves.reverse_each do |move|
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
      
        
    
    draw_mastermind_board(@moves)
      
    
end

class Game
  include Input
  attr_accessor :win

  @win = false
  
  def reset_game
    @win = false
  end

  def play
    
    board.draw_board
    until @win
      
      board.current_move = get_current_move
      game.do_turn
      board.draw_board      
  end

end

class Game_logic
#check if move is correct, build array to send to board by pushing status to array and update board, update Game.win
    def initialize
      @current_solution = []
      @current_move = []
    end

  def reset_game
    create_solution
    @current_move = []
  end
  
  def create_solution
    possible_moves = ['r','b','g','y','o','p','c','m']
    #create random solution
    4.times {@current_solution.push(possible_moves[rand(0..7)])}
  end

  def is_current_move_win(current_move, current_solution)
    if current_move == current_solution
      game.win = true
    end
  end

  def how_many_correct_colors(current_move, current_solution)
    total_correct = 0
  
    # Iterate through each element of the current_move array
    current_move.each_with_index do |color, index|
      if current_solution.include?(color)
        total_correct += 1
        # To avoid counting the same color twice, remove it from current_solution
        current_solution.delete_at(current_solution.index(color))
      end
    end
  
    total_correct
  end
  
  def how_many_correct_positions(current_move, current_solution)
    total_correct = 0
  
    # Iterate through each element of the current_move and current_solution arrays
    current_move.each_with_index do |color, index|
      if color == current_solution[index]
        total_correct += 1
      end
    end
  
    total_correct
  end

  def update_board_moves
    board.moves = board.moves.push(@current_move)
  end

  def do_turn
    is_current_move_win
    how_many_correct_colors
    how_many_correct_positions
    update_board_moves
  end
end

module Input 

  def get_current_move
    valid_colors = %w[r b g y o p c m]
    
    loop do
      puts "Input current move. RBBR = Red, Blue, Blue, Red"
      current_move = gets.chomp.downcase
  
      # Check if the input consists of valid colors and has exactly 4 characters
      if current_move.match?(/^[#{valid_colors.join}]{4}$/)
        return current_move
      else
        puts "Invalid input. Please enter a valid move with 4 characters from: #{valid_colors.join(', ')}"
      end
    end
  end
  

end


board = Board.new
game = Game.new
logic = Game_logic.new
game.play



