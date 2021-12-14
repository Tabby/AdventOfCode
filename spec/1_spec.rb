# frozen_string_literal: true

require_relative '../1'

describe AOC::D1 do
  describe 'Day 1' do
    context 'Example input' do
      it 'Puzzle 1 gives correct answer' do
        subject = AOC::D1.new([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
        expect(subject.p1).to eq(7)
      end

      it 'Puzzle 2 gives correct answer' do
        subject = AOC::D1.new([607, 618, 618, 617, 647, 716, 769, 792])
        expect(subject.p2).to eq(5)
      end
    end

    context 'Real input' do
      subject { AOC::D1.new(File.read('spec/input/1.txt').split.map(&:to_i)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq(1451)
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq(1395)
      end
    end
  end
end
