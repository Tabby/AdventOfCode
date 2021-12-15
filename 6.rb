# frozen_string_literal: true

module AOC
  class D6
    attr_reader :fish

    def initialize(input)
      @fish = parse_input(input)
    end

    def p1
      80.times { tick }
      @fish.length
    end

    def p2
      # TODO: this causes my chromebook to lock up and reboot after an hour and a bit, lol XD
      256.times { tick }
      @fish.length
    end

    def parse_input(input)
      input[0].split(',').each_with_object([]) do |timer, fish|
        fish << Fish.new(timer.to_i)
      end
    end

    def spawn_fish
      @fish_to_add << Fish.new(8)
    end

    def tick
      @fish.concat(@fish.each_with_object([]) do |fish, fish_to_add|
        new_fish = fish.tick
        fish_to_add << new_fish unless new_fish.nil?
      end)
    end
  end

  class Fish
    attr_reader :timer

    def initialize(timer, &block)
      @timer = timer
      @spawn_fish = block
    end

    def tick
      @timer -= 1
      return nil unless @timer.negative?

      @timer = 6
      Fish.new(8)
    end
  end
end
