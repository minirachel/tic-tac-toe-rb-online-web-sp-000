WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,4,8], #left diagonals
  [2,4,6], #right diagonals
  [0,3,6], #left columns
  [1,4,7], #middle column
  [2,5,8] #right column
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

##NOV 16 ERRORS
    # plays the first few turns of the game (FAILED - 2)
    # checks if the game is won after every turn (FAILED - 3)
    # checks if the game is draw after every turn (FAILED - 4)
    # plays through an entire game (FAILED - 5)
##I think I need to reformat so it is in a TRUE format - until?
def play(board)
  if !over?(board)
    turn(board)
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

def turn_count(board)
counter = 0
  board.count do |square|
    if square == "X" || square == "O"
      counter += 1
    end
  end
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
    if !over?(board)
      turn(board)
    else
    play(board)
    end
  end
end
#  asks for input again after a failed validation (FAILED - 1)

def won?(board)
    WIN_COMBINATIONS.detect {|win_combination| board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]] && position_taken?(board, win_combination[0])}
end

def full?(board)
  board.all? {|spot| spot == "X" || spot == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  else
    puts "no winner!"
  end
end
