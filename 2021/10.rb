# frozen_string_literal: true

module AOC
  class D10
    BRACKET_TYPES = {
      '(' => :round,
      ')' => :round,
      '[' => :square,
      ']' => :square,
      '{' => :curly,
      '}' => :curly,
      '<' => :angle,
      '>' => :angle
    }.freeze

    SYNTAX_ERROR_POINTS = {
      ')': 3,
      ']': 57,
      '}': 1197,
      '>': 25_137
    }.freeze

    AUTOCOMPLETE_POINTS = {
      round: 1,
      square: 2,
      curly: 3,
      angle: 4
    }.freeze

    def initialize(input)
      @input = input
    end

    def p1
      @input.reduce(0) do |sum, line|
        result = parse(line)

        if %i[valid incomplete].include? result[:status]
          sum
        else
          sum + result[:score]
        end
      end
    end

    def p2
      sorted_scores = @input.each_with_object([]) do |line, scores|
        result = parse(line)
        next scores if result[:status] != :incomplete

        scores << autocomplete(result[:stack])
      end.sort
      sorted_scores[sorted_scores.length / 2]
    end

    def autocomplete(stack)
      stack.reverse.reduce(0) do |sum, item|
        sum *= 5
        sum + AUTOCOMPLETE_POINTS[item]
      end
    end

    def parse(line)
      end_stack = line.split('').each_with_object([]) do |symbol, stack|
        case symbol
        when '('
          stack << :round
        when '['
          stack << :square
        when '{'
          stack << :curly
        when '<'
          stack << :angle
        when ')'
          return corrupt_status(symbol) if stack.pop != :round
        when ']'
          return corrupt_status(symbol) if stack.pop != :square
        when '}'
          return corrupt_status(symbol) if stack.pop != :curly
        when '>'
          return corrupt_status(symbol) if stack.pop != :angle
        end
      end
      return { status: :valid } if end_stack.empty?

      { status: :incomplete, stack: end_stack }
    end

    def corrupt_status(symbol)
      { status: :corrupt, score: SYNTAX_ERROR_POINTS[symbol.to_sym] }
    end
  end
end
