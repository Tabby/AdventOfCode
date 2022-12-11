# frozen_string_literal: true

module AOC
  class D5
    attr_reader :lines, :width, :height

    def initialize(input)
      @width = 0
      @height = 0
      @lines = parse_input(input)
      @field = Field.new(@width, @height)
    end

    def p1
      @lines.select { |x| horizontal_or_vertical?(x) }.each do |line|
        @field.add_points(get_points_from_line(line))
      end
      @field.count_danger_points
    end

    def p2
      @lines.each do |line|
        @field.add_points(get_points_from_line(line))
      end
      @field.count_danger_points
    end

    # Predicate to determine if a line is horizontal/vertical rather than diagonal
    def horizontal_or_vertical?(line)
      line[:start][:x] == line[:finish][:x] || line[:start][:y] == line[:finish][:y]
    end

    # Turns a line of input into start and finish coordinates
    #
    # The if block is because a horizontal/vertical line will only have a single value for the x/y coordinate,
    # which means it can't be nicely interleaved with zip
    # (it gives things like [{x: 1, y: 1}, {x: 2, y: nil}, {x:3, y:nil}])
    #
    # @example A line going from 1,1 -> 1,3
    #   get_points_from_line({start: {x: 1, y: 1}, finish: {x:1, y:3}}) #=> [{x: 1, y: 1}, {x: 1, y: 2}, {x: 1, y: 3}]
    def get_points_from_line(line)
      enumerables_for_line(line) => { x_enumerator:, y_enumerator: }
      if horizontal_or_vertical?(line)
        x_enumerator.each_with_object([]) do |x, points|
          y_enumerator.each do |y|
            points << { x: x, y: y }
          end
        end
      else
        x_enumerator.zip(y_enumerator).each_with_object([]) do |pair, points|
          points << { x: pair[0], y: pair[1] }
        end
      end
    end

    private

    # Parses the input into an array of hashes with start and end coordinates
    # @example A single input line going from 1,1 to 1,3
    #   parse_input('1,1 -> 1,3') #=> [{start: {x: 1, y: 1}, finish: {x:1, y:3}}]
    def parse_input(input)
      input.each_with_object([]) do |line, lines|
        start, finish = line.split(' -> ').map { |x| [%i[x y], x.split(',').map(&:to_i)].transpose.to_h }
        lines << { start: start, finish: finish }
        @width = [@width, start[:x], finish[:x]].max
        @height = [@height, start[:y], finish[:y]].max
      end
    end

    # Get the enumerators for a line
    #
    # Normally I'd just use a range like (0..5) but you can't iterate over those if they count up.
    # So if we're counting up, we can use a range but if counting down we need to use downto
    def enumerables_for_line(line)
      line => { start:, finish: }
      {
        x_enumerator: start[:x] < finish[:x] ? start[:x]..finish[:x] : start[:x].downto(finish[:x]),
        y_enumerator: start[:y] < finish[:y] ? start[:y]..finish[:y] : start[:y].downto(finish[:y])
      }
    end
  end

  # Represents the 2D space in which the hydrothermal vents from the challenge are laid out
  class Field
    def initialize(width, height)
      @width = width
      @height = height
      @values = Array.new(@width + 1) { Array.new(@height + 1, 0) }
    end

    # Adds a set of points to the field
    def add_points(points)
      points.each do |point|
        @values[point[:x]][point[:y]] += 1
      end
    end

    # Counts the number of points where 2 or more vents overlap
    def count_danger_points
      @values.reduce(0) do |agg, x|
        agg + x.reduce(0) do |y_agg, y|
          y > 1 ? y_agg + 1 : y_agg
        end
      end
    end

    # Pretty pictures
    def to_s
      str = String.new(" 0123456789\n")
      (0..@height).each do |y|
        str << y.to_s
        (0..@width).each do |x|
          str << (@values[x][y].zero? ? '.' : @values[x][y].to_s)
        end
        str << "\n"
      end
      str
    end
  end
end
