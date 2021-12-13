# frozen_string_literal: true

module AOC
  class D3
    # param input [Array<String>] input array
    def self.p1(input)
      input_bits = input[0].length - 1
      counts = count_bits(input.map { |x| x.to_i(2) }, input_bits)
      gamma = status(counts, input_bits)
      epsilon = status(counts, input_bits, most_common: false)
      gamma * epsilon
    end

    def self.p2(input)
      input_bits = input[0].length - 1
      oxygen_rating = oxygen_generator_rating(input, input_bits)
      co2_rating = co2_scrubber_rating(input, input_bits)
      oxygen_rating * co2_rating
    end

    def self.oxygen_generator_rating(input, input_bits)
      filtered_input = input.dup.map { |x| x.to_i(2) }
      (0..input_bits).each do |i|
        ones, zeros = count_bits(filtered_input, input_bits)
        filtered_input.select! do |number|
          filter_bits(number, i, input_bits) { most_common?(i, ones, zeros) }
        end
        return filtered_input[0] if filtered_input.length == 1
      end
    end

    def self.co2_scrubber_rating(input, input_bits)
      filtered_input = input.dup.map { |x| x.to_i(2) }
      (0..input_bits).each do |i|
        ones, zeros = count_bits(filtered_input, input_bits)
        filtered_input.select! do |number|
          filter_bits(number, i, input_bits) { least_common?(i, ones, zeros) }
        end
        return filtered_input[0] if filtered_input.length == 1
      end
    end

    def self.most_common?(bit, ones, zeros)
      ones[bit] >= zeros[bit]
    end

    def self.least_common?(bit, ones, zeros)
      zeros[bit] > ones[bit]
    end

    def self.filter_bits(num, bit, input_bits)
      raise ArgumentError('Need predicate') unless block_given?

      bit_set = (num & bit_value(bit, input_bits)).positive?
      yield ? bit_set : !bit_set
    end

    def self.count_bits(input, input_bits)
      counts = Array.new(input_bits + 1, 0)
      input.each do |value|
        (0..input_bits).each do |i|
          counts[i] += 1 if (value & bit_value(i, input_bits)).positive?
        end
      end
      [counts, counts.map { |x| input.length - x }]
    end

    def self.status(counts, input_bits, most_common: true)
      ones, zeros = counts
      (0..input_bits).reduce(0) do |agg, i|
        agg + if most_common
                (ones[i] > zeros[i] ? 1 : 0) * bit_value(i, input_bits)
              else
                (ones[i] > zeros[i] ? 0 : 1) * bit_value(i, input_bits)
              end
      end
    end

    def self.bit_value(pos, input_bits)
      2**(input_bits - pos)
    end

    private_class_method :status, :bit_value
  end
end
