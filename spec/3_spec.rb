# frozen_string_literal: true

require_relative '../3'

EXAMPLE_INPUT_3 = %w[
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
].freeze

describe AOC::D3 do
  describe 'Day 3' do
    context 'Puzzle 1' do
      it 'gives correct answer with example input' do
        expect(AOC::D3.p1(EXAMPLE_INPUT_3)).to eq(198)
      end
      it 'gives correct answer with real input' do
        input = File.readlines('spec/input/3.txt').map(&:strip)
        expect(AOC::D3.p1(input)).to eq(738_234)
      end
    end

    context 'Puzzle 2' do
      it 'gives correct answer with example input' do
        expect(AOC::D3.p2(EXAMPLE_INPUT_3)).to eq(230)
      end
      it 'gives correct answer with real input' do
        input = File.readlines('spec/input/3.txt').map(&:strip)
        expect(AOC::D3.p2(input)).to eq(3_969_126)
      end
    end
  end
end
