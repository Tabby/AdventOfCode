# frozen_string_literal: true

require_relative '../10'

describe AOC::D10 do
  describe 'Day 10' do
    context 'Example input' do
      subject { AOC::D10.new(File.readlines('spec/input/10_example.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq 26_397
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq 288_957
      end
    end

    context 'Real input' do
      subject { AOC::D10.new(File.readlines('spec/input/10.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq 316_851
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq 2_182_912_364
      end
    end
  end
end
