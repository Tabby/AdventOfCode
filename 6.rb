# frozen_string_literal: true

module AOC
  class D6
    attr_reader :fish

    def initialize(input)
      @fish = parse_input(input)
    end

    def p1
      run_simulation(80)
    end

    def p2
      # TODO: this causes my chromebook to lock up and reboot after an hour and a bit, lol XD
      run_simulation(256)
    end

    def run_simulation(ticks)
      ticks.times { tick }
      (0..8).reduce(0) do |agg, i|
        agg + @fish[i]
      end
    end

    def parse_input(input)
      input[0].split(',').map(&:to_i).each_with_object(Hash.new(0)) do |timer, fish|
        fish[timer] = fish[timer] + 1
      end
    end

    def tick
      new_fish = @fish[0]
      (0..7).each do |i|
        fish[i] = fish[i + 1]
      end
      fish[6] += new_fish # Fish whose timers were 0 at the start of this tick
      fish[8] = new_fish # Newly spawned fish from those whose timers were 0 at the start of this tick
    end
  end
end
