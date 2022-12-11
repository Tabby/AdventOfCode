# frozen_string_literal: true

module AOC
  class D2
    attr_accessor :input

    # param input [Array<Hash<symbol, string>>] input array
    def initialize(input)
      @input = input
    end

    def p1
      input.reduce(0) do |sum, round|
        them = shape_from_label(round[:them])
        us = p1_response(round[:us])
        sum + us.compare_to(them) + us.score
      end
    end

    def p2
      input.reduce(0) do |sum, round|
        them = shape_from_label(round[:them])
        us = p2_response(round[:us], them)
        sum + us.compare_to(them) + us.score
      end
    end

    def p1_response(label)
      return Shape::ROCK if label == 'X'
      return Shape::PAPER if label == 'Y'

      Shape::SCISSORS
    end

    def p2_response(label, theirs)
      case label
      when 'X' # Lose
        Shape.from_sym(theirs.beats)
      when 'Y' # Draw
        theirs
      when 'Z' # Win
        Shape::ALL.find { |shape| shape.beats == theirs.name }
      end
    end

    def shape_from_label(label)
      case label
      when 'A'
        Shape::ROCK
      when 'B'
        Shape::PAPER
      when 'C'
        Shape::SCISSORS
      end
    end
  end

  class Shape
    attr_accessor :name, :score, :beats

    def initialize(name, score, beats)
      @name = name
      @score = score
      @beats = beats
    end

    ROCK = new(:rock, 1, :scissors).freeze
    PAPER = new(:paper, 2, :rock).freeze
    SCISSORS = new(:scissors, 3, :paper).freeze
    ALL = [ROCK, PAPER, SCISSORS].freeze

    def compare_to(other)
      raise ArgumentError('Not a Shape') unless other.is_a? Shape

      return 6 if other.name == beats   # win
      return 0 if other.beats == name   # lose

      3 # draw
    end

    def self.from_sym(sym)
      return ROCK if sym == :rock
      return PAPER if sym == :paper

      SCISSORS
    end
  end
end
