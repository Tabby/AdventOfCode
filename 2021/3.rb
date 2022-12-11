# frozen_string_literal: true

module AOC
  class D3
    def initialize(input)
      @input = input.map { |x| x.to_i(2) }
      @input_bits = input[0].length - 1
    end

    def p1
      status => {gamma:, epsilon:}
      gamma * epsilon
    end

    def p2
      oxygen_rating = status2(:most_common?)
      co2_rating = status2(:least_common?)
      oxygen_rating * co2_rating
    end

    private

    def status
      ones, zeros = count_bits(@input)
      (0..@input_bits).each_with_object({ gamma: 0, epsilon: 0 }) do |i, agg|
        agg[:gamma] += (ones[i] > zeros[i] ? 1 : 0) * bit_value(i)
        agg[:epsilon] += (ones[i] > zeros[i] ? 0 : 1) * bit_value(i)
        agg
      end
    end

    def status2(predicate_func)
      filtered_input = @input.dup
      (0..@input_bits).each do |i|
        ones, zeros = count_bits(filtered_input)
        filtered_input.select! do |number|
          filter_bits(number, i) { method(predicate_func).call(ones[i], zeros[i]) }
        end
        return filtered_input[0] if filtered_input.length == 1
      end
    end

    # Predicate to determine if ones are more common than or as common as zeros
    # @param ones [Integer] count of ones in the current bit position
    # @param zeros [Integer] count of zeros in the current bit position
    def most_common?(ones, zeros)
      ones >= zeros
    end

    # Predicate to determine if zeros are more common than ones
    # @param ones [Integer] count of ones in the current bit position
    # @param zeros [Integer] count of zeros in the current bit position
    def least_common?(ones, zeros)
      zeros > ones
    end

    # Determine whether to select values with a 1 or a 0 in the current position
    # @param num [Integer] Value to check
    # @param bit [Integer] Bit position to check
    def filter_bits(num, bit)
      raise ArgumentError('Need predicate') unless block_given?

      bit_set = (num & bit_value(bit)).positive?
      yield ? bit_set : !bit_set
    end

    # Count the number of ones and zeros in each bit position across the given array
    # @param input [Array<Integer>] Array of values
    def count_bits(input)
      counts = Array.new(@input_bits + 1, 0)
      input.each do |value|
        (0..@input_bits).each do |i|
          counts[i] += 1 if (value & bit_value(i)).positive?
        end
      end
      [counts, counts.map { |x| input.length - x }]
    end

    # Calculate the value of each bit position as a decimal
    # @param pos [Integer] bit position to calculate
    # @example Calculate value of 0b010000
    #   bit_value(4) #=> 16
    def bit_value(pos)
      2**(@input_bits - pos)
    end
  end
end
