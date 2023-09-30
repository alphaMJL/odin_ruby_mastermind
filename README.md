# odin_ruby_mastermind
Ruby console mastermind game

This readme will contain the requirements and notes on my development process

Requirements:
Build a Mastermind game from the command line where you have 12 turns to guess the secret code, starting with you guessing the computer’s random code.


Build the game assuming the computer randomly selects the secret colors and the human player must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!
Now refactor your code to allow the human player to choose whether they want to be the creator of the secret code or the guesser.
Build it out so that the computer will guess if you decide to choose your own secret colors. You may choose to implement a computer strategy that follows the rules of the game or you can modify these rules.
If you choose to modify the rules, you can provide the computer additional information about each guess. For example, you can start by having the computer guess randomly, but keep the ones that match exactly. You can add a little bit more intelligence to the computer player so that, if the computer has guessed the right color but the wrong position, its next guess will need to include that color somewhere.
If you want to follow the rules of the game, you’ll need to research strategies for solving Mastermind, such as this post.
Post your solution below!




Initial Development plan - attemped to plan OOP design

1. Board class
    i. attributes
        a. piece locations and color
    ii. behavior
        a. draw board - updates board, displays key


2. game class
    i. attributes
        game settings - current code to guess
    behavior 

        ====Game loop====
        Display board
        take input
        set play current move
        get results
        send progress to game board
        if win, end

3. cpu_player class - supplies inputs to game and takes outputs to make next chocie
    i. attributes:
        a. current game/board knowledge
        b. next play
        c. last play
    ii. choices:
        a. solving algo internal method


4. play game_logic
    i. attributes
        a. current move
    ii. behavior
        a. take current move, is correct? how many color correct? how many place correct?
        b. is_win?()
        c. num_colors_correct?()
        d. num_positions_correct?()
        e. return_results()

5. input module
    i. methods for inputs
        a. game type
        b. turn
        c. secret code(maker - cpu guesser)
        d. play again
        



I've had some issues with scoping. I assumed that the classes inheritied from the main scope, which is not the case. I got around this by passing the classes into other classes, but I don't feel this is ideal and it is causing problems.

Game is working well as a human guesser, but implementing AI that does more than throw random answers has been a challenge. I am running into an issue of tracking too much state across different classes and the complexity is spiraling out of control. I believe this is because I need to more properly design the program. I will study OOP design and see if I can use that to refactor into a workable solution



Psuedocode to try to solve this problem:

>take first color and repeat 4 times
>check how many correct colors increased from 0
>take this color and keep this number of colors for starting of next answers as [starting colors]
>
>{finding colors}
>UNTIL [starting_colors] is full (length = 4) do
>start with [starting colors] from last answers, fill next color to try.
>
>add the number of increase for correct colors of selected color to [starting colors]

>if increase of correct colors and correct colors+positions are the same, then added colors are in correct positions.

