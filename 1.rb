# frozen_string_literal: true

module AOC
  class D1
    # param input [Array<Integer>] input array
    def initialize(input)
      @input = input
    end

    def p1
      previous_depth = -1
      increase = 0
      @input.each do |depth|
        increase += 1 if previous_depth.positive? && previous_depth < depth
        previous_depth = depth
      end
      increase
    end

    def p2
      increase = 0
      previous_slice = []
      current_slice = []
      @input.each do |depth|
        next_value(previous_slice, current_slice.last) unless current_slice.empty?
        next_value(current_slice, depth)
        increase += 1 if slice_increased?(previous_slice, current_slice)
      end
      increase
    end

    private

    # Adds a value to the given array and discards the first value from the array if it now holds more than 3 values
    # @param arr [Array<Integer>] Array to append to
    # @param val Integer Value to appent to array
    def next_value(arr, val)
      arr << val
      arr.shift if arr.length > 3
    end

    # param prev [Array<Integer>] previous slice
    # param current [Array<Integer>] current slice
    def slice_increased?(prev, current)
      return false unless prev.length == 3 && current.length == 3

      current.sum > prev.sum
    end
  end
end
