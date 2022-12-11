# frozen_string_literal: true

require_relative '../1'

describe AOC::D1 do
  describe 'Day 1' do
    context 'Example input' do
      subject do
        AOC::D1.new(File.read('spec/input/1_example.txt').split("\n"))
      end

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq(24_000)
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq(45_000)
      end
    end

    context 'Real input' do
      subject do
        AOC::D1.new(File.read('spec/input/1.txt').split("\n"))
      end

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq(65_912)
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq(195_625)
      end
    end
  end
end
