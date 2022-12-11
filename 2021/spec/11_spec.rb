# frozen_string_literal: true

require_relative '../11'

describe AOC::D11 do
  describe 'Day 11' do
    context 'Example input' do
      subject { AOC::D11.new(File.readlines('spec/input/11_example.txt').map(&:strip)) }

      it 'parses the input correctly' do
        expect(subject.field[4]).to eq [6, 3, 5, 7, 3, 8, 5, 4, 7, 8]
      end

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq 1656
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq 195
      end
    end

    context 'Real input' do
      subject { AOC::D11.new(File.readlines('spec/input/11.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq 1785
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq 354
      end
    end
  end
end
