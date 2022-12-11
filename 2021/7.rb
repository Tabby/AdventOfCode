# frozen_string_literal: true

module AOC
  class D7
    attr_reader :crabs

    def initialize(input)
      @crabs = parse_input(input)
    end

    def p1
      align_crabs do |distance|
        distance
      end
    end

    def p2
      align_crabs do |distance|
        # Sum a sequence of n integers [a..z]: (n*(a+z))/2
        (distance * (distance + 1)) / 2
      end
    end

    # For each potential crab position (0 up to the highest crab starting position),
    #   calculate the fuel needed to move the crabs to that position and update the
    #   min_fuel aggregator if the new value is smaller
    # @param block [Proc] block which calculates the amount of fuel consumed by moving a given distance
    # @return [Integer] the smallest fuel value found after checking all positions
    def align_crabs(&block)
      (0..@crabs.keys.max).reduce(nil) do |min_fuel, position|
        fuel_required = @crabs.keys.reduce(0) do |fuel, key|
          fuel + (block.call((key - position).abs) * @crabs[key])
        end
        min_fuel.nil? || min_fuel > fuel_required ? fuel_required : min_fuel
      end
    end

    def parse_input(input)
      input[0].split(',').map(&:to_i).each_with_object(Hash.new(0)) do |position, crabs|
        crabs[position] = crabs[position] + 1
      end
    end
  end
end
