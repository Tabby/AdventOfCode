# frozen_string_literal: true

require 'set'

module AOC
  class D9
    attr_reader :field

    def initialize(input)
      @field = input.reduce([]) do |field, line|
        field << line.split('').map(&:to_i).reduce([]) do |row, height|
          row << height
        end
      end
    end

    def find_minima
      possible_minima = Set.new
      @field.each_with_index do |row, y|
        row.each_with_index do |height, x|
          possible_minima << { x: x, y: y } if possible_minima?(height, x, y)
        end
      end
      possible_minima
    end

    # For the given minimum, finds all the spaces around it that make up the "basin" and returns the size of the basin
    # A basin is all the numbers near a minimum that are not 9s
    def basin_size(minimum)
      basin = Set.new([minimum])
      points_to_check = Set.new
      adjacent_points(minimum, points_to_check, basin)
      until points_to_check.empty?
        point = points_to_check.first
        points_to_check.delete(point)
        if height_from_point(point) < 9
          basin << point
          adjacent_points(point, points_to_check, basin)
        end
      end
      basin.length
    end

    def p1
      minima = find_minima
      minima.reduce(0) do |sum, minimum|
        sum + (height_from_point(minimum) + 1)
      end
    end

    def p2
      minima = find_minima
      basin_sizes = minima.each_with_object([]) do |minimum, agg|
        agg << basin_size(minimum)
      end.sort.reverse
      basin_sizes[0] * basin_sizes[1] * basin_sizes[2]
    end

    private

    def adjacent_points(minimum, points_to_check, basin)
      point_left(minimum, points_to_check, basin)
      point_right(minimum, points_to_check, basin)
      point_above(minimum, points_to_check, basin)
      point_below(minimum, points_to_check, basin)
    end

    def point_above(minimum, points_to_check, basin)
      point = { x: minimum[:x], y: minimum[:y] - 1 }
      points_to_check << point if minimum[:y].positive? && !basin.include?(point)
    end

    def point_below(minimum, points_to_check, basin)
      point = { x: minimum[:x], y: minimum[:y] + 1 }
      points_to_check << point if minimum[:y] < @field.length - 1 && !basin.include?(point)
    end

    def point_left(minimum, points_to_check, basin)
      point = { x: minimum[:x] - 1, y: minimum[:y] }
      points_to_check << point if minimum[:x].positive? && !basin.include?(point)
    end

    def point_right(minimum, points_to_check, basin)
      point = { x: minimum[:x] + 1, y: minimum[:y] }
      points_to_check << point if minimum[:x] < @field[0].length - 1 && !basin.include?(point)
    end

    def possible_minima?(height, pos_x, pos_y)
      less_than_above?(height, pos_x, pos_y) &&
        less_than_below?(height, pos_x, pos_y) &&
        less_than_left?(height, pos_x, pos_y) &&
        less_than_right?(height, pos_x, pos_y)
    end

    def less_than_above?(height, pos_x, pos_y)
      pos_y.zero? || @field[pos_y - 1][pos_x] > height
    end

    def less_than_below?(height, pos_x, pos_y)
      pos_y == (@field.length - 1) || @field[pos_y + 1][pos_x] > height
    end

    def less_than_left?(height, pos_x, pos_y)
      pos_x.zero? || @field[pos_y][pos_x - 1] > height
    end

    def less_than_right?(height, pos_x, pos_y)
      pos_x == (@field[pos_y].length - 1) || @field[pos_y][pos_x + 1] > height
    end

    def height_from_point(point)
      @field[point[:y]][point[:x]]
    end
  end
end
