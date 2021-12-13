# frozen_string_literal: true

module AOC
  class D1
    # param input [Array<Integer>] input array
    def self.p1(input)
      previous_depth = -1
      increase = 0
      input.each do |depth|
        increase += 1 if previous_depth.positive? && previous_depth < depth
        previous_depth = depth
      end
      increase
    end

    # param input [Array<Integer>] input array
    def self.p2(input)
      increase = 0
      previous_slice = []
      current_slice = []
      input.each do |depth|
        next_value(previous_slice, current_slice.last) unless current_slice.empty?
        next_value(current_slice, depth)
        increase += 1 if slice_increased?(previous_slice, current_slice)
      end
      increase
    end

    def self.next_value(arr, val)
      arr << val
      arr.shift if arr.length > 3
    end

    # param prev [Array<Integer>] previous slice
    # param current [Array<Integer>] current slice
    def self.slice_increased?(prev, current)
      return false unless prev.length == 3 && current.length == 3

      current.sum > prev.sum
    end

    private_class_method :slice_increased?, :next_value
  end
end
