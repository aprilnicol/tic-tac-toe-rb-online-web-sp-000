board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
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
def move(board, index, player)
  board[index]= player
end
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
def turn_count(board)
  counter = 0
  board.each do |tokens|
    if tokens == "X" || tokens == "O"
      counter +=1
    end
  end
  counter
end
def current_player(board)
 if turn_count(board) % 2 == 0
   return "X"
  else
   return "O"
end
end
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    turn(board)
    puts "Please enter 1-9:"
  end
  display_board(board)
end
def won?(board)
  WIN_COMBINATIONS.each do
    |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
      return win_combination
    end
end
return false
end
def full?(board)
  if board.any? {|full_board| full_board == nil || full_board == " "}
    return false
  else
    return true
  end
end
def draw?(board)
   if !won?(board) && full?(board)
     return true
   !full?(board) && !won?(board)
     return false
   else won?(board)
     return false
   end
end
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end
def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end
def play(board)
   counter = 0
   until counter == 9
     turn(board)
     counter += 1
   end
end
def play(board)
   until over?(board)
      turn(board)
   end
   if won?(board)
      winner(board) == "X" || winner(board) == "O"
      puts "Congratulations #{winner(board)}!"
   elsif draw?(board)
      puts "Cat's Game!"
   end
end
