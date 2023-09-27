class Board
  attr_accessor :moves
  #contains placeholders. Will initialize to empty array.
  moves = [
    ['X', 'O', 'Y', 'G', 2, 1],
    ['R', 'B', 'G', 'Y', 0, 0],
    # Add more moves here...
  ]

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
    | #{code_1} | #{code_2} | #{code_3} | #{code_4} |  | #{correct_colors} | #{correct_positions} |
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
      
        
    
    draw_mastermind_board(moves)
      
    
end