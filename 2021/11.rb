# frozen_string_literal: true

require 'set'

module AOC
  class D11
    attr_reader :field

    def initialize(input)
      @data = Octopuses.new
      input.each_with_index do |line, y|
        line.split('').map(&:to_i).each_with_index do |energy, x|
          @data.add(energy, x, y)
        end
      end
    end

    def p1
      100.times.reduce(0) do |agg|
        agg + @data.step
      end
    end

    def p2
      num_octopuses = @data.count
      count = 1
      count += 1 while @data.step < num_octopuses
      count
    end
  end

  class Octopuses
    attr_reader :count

    def initialize
      @octopuses = []
      @count = 0
      @width = 0
      @height = 0
    end

    def add(energy, pos_x, pos_y)
      @octopuses << {
        energy: energy,
        position: {
          x: pos_x,
          y: pos_y
        }
      }
      @count += 1
      @width = pos_x if pos_x > @width
      @height = pos_y if pos_y > @height
    end

    def step
      @octopuses.each { |x| x[:energy] += 1 }
      flashed = Set.new
      flash(@octopuses.select { |x| x[:energy] > 9 }, flashed)
      flashed.each do |position|
        @octopuses.select { |octopus| octopus[:position] == position }.first[:energy] = 0
      end
      flashed.length
    end

    def flash(octopuses, flashed)
      octopuses.each do |octopus|
        next if flashed.include? octopus[:position]

        flashed << octopus[:position]
        # Increase adjacent octopi energy by 1 and flash if necessary
        adjacent = adjacent_octopi(octopus[:position]).each { |x| x[:energy] += 1 }
                                                      .select { |x| x[:energy] > 9 }
        flash(adjacent, flashed)
      end
    end

    def adjacent_octopi(octopus)
      adjacent = []
      x_lower = octopus[:x].positive? ? octopus[:x] - 1 : octopus[:x]
      x_upper = octopus[:x] < @width ? octopus[:x] + 1 : octopus[:x]
      y_lower = octopus[:y].positive? ? octopus[:y] - 1 : octopus[:y]
      y_upper = octopus[:y] < @height ? octopus[:y] + 1 : octopus[:y]
      (x_lower..x_upper).each do |x|
        (y_lower..y_upper).each do |y|
          next if x == octopus[:x] && y == octopus[:y]

          adjacent << @octopuses.select { |item| item[:position][:x] == x && item[:position][:y] == y }.first
        end
      end
      adjacent
    end
  end
end
