# frozen_string_literal: true

require 'set'

module AOC
  class D4
    attr_reader :boards, :draw_numbers

    def initialize(input)
      @boards = []
      @draw_numbers = input.shift.split(',').map(&:to_i)
      input.shift # discard blank line
      parse_input(input)
    end

    def p1()
      winning_board = call_numbers
      calculate_answer(winning_board)
    end

    def p2()
      until @boards.length == 1
        winning_board = call_numbers
        @boards.delete(winning_board)
      end
      losing_board = call_numbers
      calculate_answer(losing_board)
    end

    def calculate_answer(board)
      board
        .numbers
        .select { |x| x[:called] == false }
        .map { |x| x[:number] }
        .sum * @last_called_number
    end

    def parse_input(input)
      current_board = []
      line = ''

      until line.nil?
        line = input.shift
        if line.nil? || line.length.zero?
          @boards << BingoBoard.new(current_board)
          current_board = []
          break if line.nil?
        else
          current_board << line.split(' ').map(&:to_i)
        end
      end
    end

    def call_numbers
      if last_call_incomplete?
        @boards.each do |board|
          return board if board.mark(@last_called_number)
        end
      end
      while @draw_numbers.length.positive?
        called_number = @draw_numbers.shift
        @last_called_number = called_number
        @boards.each do |board|
          return board if board.mark(called_number)
        end
      end
      raise 'No winning boards :('
    end

    def last_call_incomplete?
      @last_called_number &&
        @boards.any? do |board|
          board.numbers.select { |x| x[:number] == @last_called_number && !x[:called] }
        end
    end
  end

  class BingoBoard
    attr_reader :winning_line, :numbers

    def initialize(lines)
      @size = lines.length - 1
      @numbers = Set.new
      lines.each_with_index do |line, y|
        line.each_with_index do |number, x|
          @numbers << {
            number: number,
            called: false,
            x: x,
            y: y
          }
        end
      end
    end

    # Marks a number on the card and checks if the card has won
    # @param number [Integer] number that was called
    # @return [Boolean] whether or not the card has won
    def mark(number)
      item = @numbers.find { |x| x[:number] == number }
      if item.nil?
        false
      else
        item[:called] = true
        won?
      end
    end

    def won?
      (0..@size).each do |i|
        return true if row_won?(@numbers.select { |item| item[:x] == i }) ||
                       row_won?(@numbers.select { |item| item[:y] == i })
      end
      false
    end

    def row_won?(row)
      if row.all? { |item| item[:called] }
        @winning_line = row.map { |item| item[:number] }
        true
      else
        false
      end
    end
  end
end
