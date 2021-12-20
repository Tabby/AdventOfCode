# frozen_string_literal: true

require 'set'

module AOC
  class D8
    attr_reader :lines

    def initialize(input)
      @lines = input.each_with_object([]) do |line, agg|
        patterns, outputs = line.split('|').map(&:strip)
        agg << {
          patterns: patterns.split(' ').map do |pattern|
            Set.new(pattern.split(''))
          end,
          output: outputs.split(' ').map do |output|
            Set.new(output.split(''))
          end
        }
      end
    end

    def decode_digits(line)
      # For each line, figure out the trivial numbers and use those to figure out as many other numbers as possible
      # Then, use the numbers we know to figure out as many letter mappings (broken -> real) as possible
      # Until all letter mappings have been found, repeat previous two steps but with newly found number & letter mappings
      # 1: 1 (only 2 digit number)
      # 2: 4 (only 4 digit number)
      # 3: 7 (only 3 digit number)
      # 4: 8 (only 7 digit number)
      # 5: 3 (only 5 digit with both letters from 1)
      # 6: b is letter in 4 and not in 3 or 1. d is letter that is in both 4 and 3 but not 1)
      # 7: 5 (only 5 digit with b in it. f is whichever of a/b is in 5)
      # 8: 2 (only remaining 5 digit number)
      # 9: confirm what c, f are
      # 10: find what e is - in 2 but not in 5 or 1
      # 11: 0 (know bcef, only 6 digit with all in)
      # 12: 6 (6 digit with bef in)
      # 13: 9 (only 6 digit with bcf in)
      digits = Array.new(10) { Set.new }
      wires = { a: nil, b: nil, c: nil, d: nil, e: nil, f: nil, g: nil }
      all_numbers = line[:patterns].concat(line[:output]).uniq
      digits[1] = find_length(all_numbers, 2)
      digits[4] = find_length(all_numbers, 4)
      digits[7] = find_length(all_numbers, 3)
      digits[8] = find_length(all_numbers, 7)
      digits[3] = find3(digits, all_numbers)
      digits[4].each do |wire|
        next if digits[1].include?(wire)

        if digits[3].include?(wire)
          wires[:d] = wire
        else
          wires[:b] = wire
        end
      end
      digits[5] = find5(all_numbers, wires)
      digits[1].each do |wire|
        wires[:f] = wire if digits[5].include?(wire)
      end
      digits[2] = find_length(all_numbers, 5)
      digits[4].each do |wire|
        next unless digits[2].include?(wire)

        wires[:c] = wire if wires[:d] != wire
      end
      digits[2].each do |wire|
        next if digits[5].include?(wire) || digits[1].include?(wire)

        wires[:e] = wire
      end
      digits[0] = find_six_digit(all_numbers, wires, has_c: true, has_e: true)
      digits[6] = find_six_digit(all_numbers, wires, has_e: true, has_c: false)
      digits[9] = find_six_digit(all_numbers, wires, has_e: false, has_c: true)
      digits
    end

    def find_length(all_numbers, length)
      number = all_numbers.select { |x| x.length == length }.first
      all_numbers.delete(number)
      number
    end

    def find3(digits, all_numbers)
      candidates = all_numbers.select { |x| x.length == 5 }
      candidates.each do |candidate|
        if digits[1].all? { |wire| candidate.include?(wire) }
          all_numbers.delete(candidate)
          return candidate
        end
      end
    end

    def find5(all_numbers, wires)
      number = all_numbers.select { |x| x.length == 5 && x.include?(wires[:b]) }.first
      all_numbers.delete(number)
      number
    end

    def find_six_digit(all_numbers, wires, has_c:, has_e:)
      number = all_numbers.select do |x|
        x.length == 6 &&
          x.include?(wires[:b]) &&
          has_c == x.include?(wires[:c]) &&
          has_e == x.include?(wires[:e]) &&
          x.include?(wires[:f])
      end.first
      all_numbers.delete(number)
      number
    end

    def sum_output(&block)
      @lines.reduce(0) do |sum, line|
        digits = decode_digits(line)
        sum + line[:output].each_with_index.reduce(0) do |count, (output_digit, digit_position)|
          digits.each_with_index do |digit, digit_value|
            count += block.call(digit_value, digit, output_digit, digit_position)
          end
          count
        end
      end
    end

    def p1
      sum_output do |digit_value, digit, output_digit, _|
        digit == output_digit && [1, 4, 7, 8].include?(digit_value) ? 1 : 0
      end
    end

    def p2
      sum_output do |digit_value, digit, output_digit, digit_position|
        digit == output_digit ? digit_value * (10**(3 - digit_position)) : 0
      end
    end
  end
end
