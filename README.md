# odin_ruby_mastermind
Ruby console mastermind game



Initial Development plan - 

Board class
    attributes
        piece locations and color
    behavior
        draw board - updates board, displays key



game class
    attributes
        game settings - current code to guess
    behavior 

        ====Game loop====
        Display board
        take input
        set play current move
        get results
        send progress to game board
        if win, end

cpu_player class - supplies inputs to game and takes outputs to make next chocie
    attributes:
        current game/board knowledge
        next play
        last play
    choices:
        solving algo internal method


play game_logic
    attributes
        current move
    behavior
        take current move, is correct? how many color correct? how many place correct?
        is_win?()
        num_colors_correct?()
        num_positions_correct?()
        return_results()

input module
    methods for inputs
        game type
        turn
        secret code(maker - cpu guesser)
        play again
        



Requirements:
Build a Mastermind game from the command line where you have 12 turns to guess the secret code, starting with you guessing the computer’s random code.


Build the game assuming the computer randomly selects the secret colors and the human player must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!
Now refactor your code to allow the human player to choose whether they want to be the creator of the secret code or the guesser.
Build it out so that the computer will guess if you decide to choose your own secret colors. You may choose to implement a computer strategy that follows the rules of the game or you can modify these rules.
If you choose to modify the rules, you can provide the computer additional information about each guess. For example, you can start by having the computer guess randomly, but keep the ones that match exactly. You can add a little bit more intelligence to the computer player so that, if the computer has guessed the right color but the wrong position, its next guess will need to include that color somewhere.
If you want to follow the rules of the game, you’ll need to research strategies for solving Mastermind, such as this post.
Post your solution below!