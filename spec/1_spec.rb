# frozen_string_literal: true

require_relative '../1'

describe AOC::D1 do
  describe 'Day 1' do
    context 'Puzzle 1' do
      it 'gives correct answer with example input' do
        expect(AOC::D1.p1([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])).to eq(7)
      end
      it 'gives correct answer with real input' do
        input = File.read('spec/input/1.txt').split.map(&:to_i)
        expect(AOC::D1.p1(input)).to eq(1451)
      end
    end

    context 'Puzzle 2' do
      it 'gives correct answer with example input' do
        expect(AOC::D1.p2([607, 618, 618, 617, 647, 716, 769, 792])).to eq(5)
      end
      it 'gives correct answer with real input' do
        input = File.read('spec/input/1.txt').split.map(&:to_i)
        expect(AOC::D1.p2(input)).to eq(1395)
      end
    end
  end
end
