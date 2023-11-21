class CustomTicTacToe
    def initialize
      @board = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
      @turn_count = 0
      @game_over = false
      run_game
    end
  
    def run_game
      set_up_game
      while !@game_over
        valid_move = false
        player_input = []
        loop do
          print @current_player.display_name.to_s
          print ', enter a location: '
          player_input = gets.chomp.split(",")
          valid_move = position_valid?(player_input[0].to_i, player_input[1].to_i)
          break if valid_move == true
          puts "Invalid move!"
        end
        @turn_count += 1
        @board[player_input[1].to_i][player_input[0].to_i] = @current_player.game_symbol
        check_game_over
        switch_player
        display_board
      end
      determine_winner
    end
  
    def set_up_game
      print "Enter the name for Player X: "
      x_name = gets.chomp
      print "Enter a symbol to use: "
      x_symbol = gets.chomp
      print "Enter the name for Player O: "
      o_name = gets.chomp
      print "Enter a symbol to use: "
      o_symbol = gets.chomp
      @player_x = GamePlayer.new(x_name, x_symbol)
      @player_o = GamePlayer.new(o_name, o_symbol)
      @current_player = @player_x
      display_board
    end
  
    def display_board
      puts '-------'
      for i in 0...3
        for j in 0...3
          print '|' + @board[i][j].to_s
        end
        puts '|'
        puts '-------'
      end
    end
  
    def switch_player
      @current_player = (@current_player == @player_x) ? @player_o : @player_x
    end
  
    def position_valid?(x_coord, y_coord)
      if (x_coord >= 0 && x_coord <= 2) && (y_coord >= 0 && y_coord <= 2)
        return @board[y_coord][x_coord] == ' '
      end
      false
    end
  
    def check_game_over
      check_symbol = @current_player.game_symbol
      winning_combinations = [
        [[0, 0], [0, 1], [0, 2]],
        [[1, 0], [1, 1], [1, 2]],
        [[2, 0], [2, 1], [2, 2]],
        [[0, 0], [1, 0], [2, 0]],
        [[0, 1], [1, 1], [2, 1]],
        [[0, 2], [1, 2], [2, 2]],
        [[0, 0], [1, 1], [2, 2]],
        [[2, 0], [1, 1], [0, 2]]
      ]
  
      winning_combinations.each do |combination|
        if combination.all? { |coord| @board[coord[0]][coord[1]] == check_symbol }
          @game_over = true
          break
        end
      end
  
      @game_over = true if @turn_count > 9
    end
  
    def determine_winner
      if @turn_count > 9
        puts "It's a tie game!"
      elsif @current_player == @player_x
        puts @player_o.display_name.to_s + ' wins!'
      elsif @current_player == @player_o
        puts @player_x.display_name.to_s + ' wins!'
      else
        puts "ERROR!"
      end
    end
  end
  
  class GamePlayer
    attr_reader :display_name, :game_symbol
  
    def initialize(name, symbol)
      @display_name = name.to_sym
      @game_symbol = symbol.to_sym
    end
  end
  
  custom_game = CustomTicTacToe.new
  