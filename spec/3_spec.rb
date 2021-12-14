# frozen_string_literal: true

require_relative '../3'

describe AOC::D3 do
  describe 'Day 3' do
    context 'Example input' do
      subject { AOC::D3.new(File.readlines('spec/input/3_example.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq(198)
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq(230)
      end
    end

    context 'Real input' do
      subject { AOC::D3.new(File.readlines('spec/input/3.txt').map(&:strip)) }
      
      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq(738_234)
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq(3_969_126)
      end
    end
  end
end
