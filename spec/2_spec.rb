# frozen_string_literal: true

require_relative '../2'

EXAMPLE_INPUT_2 = [
  'forward 5',
  'down 5',
  'forward 8',
  'up 3',
  'down 8',
  'forward 2'
].freeze

describe AOC::D2 do
  describe 'Day 2' do
    context 'Puzzle 1' do
      it 'gives correct answer with example input' do
        expect(AOC::D2.p1(EXAMPLE_INPUT_2)).to eq(150)
      end
      it 'gives correct answer with real input' do
        input = File.readlines('spec/input/2.txt')
        expect(AOC::D2.p1(input)).to eq(1_694_130)
      end
    end

    context 'Puzzle 2' do
      it 'gives correct answer with example input' do
        expect(AOC::D2.p2(EXAMPLE_INPUT_2)).to eq(900)
      end
      it 'gives correct answer with real input' do
        input = File.readlines('spec/input/2.txt')
        expect(AOC::D2.p2(input)).to eq(1_698_850_445)
      end
    end
  end
end
