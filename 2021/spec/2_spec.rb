# frozen_string_literal: true

require_relative '../2'

describe AOC::D2 do
  describe 'Day 2' do
    context 'Example input' do
      subject { AOC::D2.new(File.readlines('spec/input/2_example.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq(150)
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq(900)
      end
    end

    context 'Real input' do
      subject { AOC::D2.new(File.readlines('spec/input/2.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq(1_694_130)
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq(1_698_850_445)
      end
    end
  end
end
