# frozen_string_literal: true

require_relative '../7'

describe AOC::D7 do
  describe 'Day 7' do
    context 'Example input' do
      subject { AOC::D7.new(File.readlines('spec/input/7_example.txt').map(&:strip)) }

      it 'parses the input correctly' do
        expect(subject.crabs).to match_array [[0, 1], [1, 2], [2, 3], [4, 1], [7, 1], [14, 1], [16, 1]]
      end

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq 37
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq 168
      end
    end

    context 'Real input' do
      subject { AOC::D7.new(File.readlines('spec/input/7.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq 344_297
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq 97_164_301
      end
    end
  end
end
