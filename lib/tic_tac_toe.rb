require "pry"

class TicTacToe
  attr_accessor :board

  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
    [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6],
  ]
  # for each array in winCombos
  #   if each index of winCombo == the same character
  #     winCombo.every? == 'X' or 'O'
  #  then we have a win
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display_board
    puts "
     #{@board[0]} | #{@board[1]} | #{@board[2]} 
    -----------
     #{@board[3]} | #{@board[4]} | #{@board[5]} 
    -----------
     #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(str)
    str.to_i - 1
  end

  def move(index, token)
    @board[index] = token
  end

  def position_taken?(index)
    if @board[index] == "X" || @board[index] == "O"
      true
    else
      false
    end
  end

  def valid_move?(index)
    if !position_taken?(index) && index.between?(0, 8)
      true
    else
      false
    end
  end

  def turn_count
    @board.filter { |idx| idx == "O" || idx == "X" }.size
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def turn
    "please make a move"
    move = gets.chomp
    index = self.input_to_index(move)
    player = self.current_player

    if valid_move?(index)
      self.move(index, player)
      self.display_board
    else
      turn
    end
  end

  def won?
    x_won = WIN_COMBINATIONS.filter do |winCombo|
      winCombo.all? { |idx| @board[idx] == "X" }
      # binding.pry
    end
    o_won = WIN_COMBINATIONS.filter do |winCombo|
      winCombo.all? { |idx| @board[idx] == "O" }
      # binding.pry
    end

    if x_won == [] && o_won == []
      false
    elsif p "X won #{x_won.flatten}"
      x_won.flatten
    else
      p "O won #{o_won.flatten}"
      o_won.flatten
    end
  end

  def full?
    @board.all? { |idx| idx == "X" || idx == "O" }
  end

  def draw?
    self.full? && self.won? == false ? true : false
  end

  def over?
    self.won? || self.full? ? true : false
  end

  def winner
    if self.draw?
      nil
    else 
      self.turn_count.odd? ? "X" : "O"
    end
  end
end

game1 = TicTacToe.new
# game1.display_board
