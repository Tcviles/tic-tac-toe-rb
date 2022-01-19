WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.chomp)
  token = current_player(board)
  valid_move?(board, index) ? move(board, index, token) : turn(board)
  display_board(board)
end

def turn_count(board)
  i = 0
  board.each do |position|
    if position == "X" || position == "O"
      i += 1
    end
  end
  i
end

def current_player(board)
  turn_count(board)%2==0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]]!=" " && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
      return combo
    end
  end
  false
end

def valid_move?(board, index)
(position_taken?(board, index) || !index.between?(0,8)) ? false : true
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def full?(board)
  !board.include? " "
end

def draw?(board)
  full?(board) and !won?(board)
end

def over?(board)
  won?(board) or draw?(board)
end

def winner(board)
  if combo = won?(board)
    board[combo[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cat's Game!"
  end
end