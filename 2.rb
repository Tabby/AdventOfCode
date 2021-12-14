# frozen_string_literal: true

module AOC
  class D2
    # param input [Array<String>] input array
    def initialize(input)
      @depth = 0
      @h_position = 0
      @aim = 0
      @input = input
    end

    def p1
      @input.each do |movement|
        dir, amount = movement.split
        amount = amount.to_i
        case dir
        when 'forward'
          @h_position += amount
        when 'down'
          @depth += amount
        when 'up'
          @depth -= amount
        else
          raise "Unknown direction (dir: #{dir}, amount: #{amount})"
        end
      end
      @h_position * @depth
    end

    def p2
      @input.each do |movement|
        dir, amount = movement.split
        amount = amount.to_i
        case dir
        when 'forward'
          @h_position += amount
          @depth += amount * @aim
        when 'down'
          @aim += amount
        when 'up'
          @aim -= amount
        else
          raise 'Unknown direction'
        end
      end
      @h_position * @depth
    end
  end
end
