# frozen_string_literal: true

require_relative '../9'

describe AOC::D9 do
  describe 'Day 9' do
    context 'Example input' do
      subject { AOC::D9.new(File.readlines('spec/input/9_example.txt').map(&:strip)) }

      it 'parses the input correctly' do
        expect(subject.field).to match_array(
          [
            [2, 1, 9, 9, 9, 4, 3, 2, 1, 0],
            [3, 9, 8, 7, 8, 9, 4, 9, 2, 1],
            [9, 8, 5, 6, 7, 8, 9, 8, 9, 2],
            [8, 7, 6, 7, 8, 9, 6, 7, 8, 9],
            [9, 8, 9, 9, 9, 6, 5, 6, 7, 8]
          ]
        )
      end

      it 'finds local minima' do
        expected_minima = Set.new
        expected_minima << { x: 1, y: 0 }
        expected_minima << { x: 9, y: 0 }
        expected_minima << { x: 2, y: 2 }
        expected_minima << { x: 6, y: 4 }
        expect(subject.find_minima).to eq expected_minima
      end

      it 'calculates basin sizes' do
        values = [3, 9, 14, 9]
        subject.find_minima.each_with_index do |minimum, i|
          expect(subject.basin_size(minimum)).to be values[i]
        end
      end

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq 15
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq 1134
      end
    end

    context 'Real input' do
      subject { AOC::D9.new(File.readlines('spec/input/9.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq 423
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq 1_198_704
      end
    end
  end
end
