# frozen_string_literal: true

module AOC
  class D1
    attr_accessor :elves

    # param input [Array<string>] input array
    def initialize(input)
      @input = input
      @elves = [0]
      count_calories
    end

    def p1
      elves.last
    end

    def p2
      elves.slice(-3, 3).sum
    end

    private

    def count_calories
      current_elf = 0
      @input.each do |cals|
        if cals == ''
          current_elf += 1
          elves << 0
        else
          elves[current_elf] += cals.to_i
        end
      end
      elves.sort!
    end
  end
end
