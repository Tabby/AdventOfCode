# frozen_string_literal: true

require_relative '../6'

describe AOC::D6 do
  describe 'Day 6' do
    context 'Example input' do
      subject { AOC::D6.new(File.readlines('spec/input/6_example.txt').map(&:strip)) }

      it 'parses the input correctly' do
        expect(subject.fish[0]).to be 0
        expect(subject.fish[1]).to be 1
        expect(subject.fish[2]).to be 1
        expect(subject.fish[3]).to be 2
        expect(subject.fish[4]).to be 1
        expect(subject.fish[5]).to be 0
        expect(subject.fish[6]).to be 0
        expect(subject.fish[7]).to be 0
        expect(subject.fish[8]).to be 0
      end

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq(5934)
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq(26_984_457_539)
      end
    end

    context 'Real input' do
      subject { AOC::D6.new(File.readlines('spec/input/6.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq(352_195)
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq(1_600_306_001_288)
      end
    end
  end
end
