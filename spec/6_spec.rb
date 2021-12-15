# frozen_string_literal: true

require_relative '../6'

describe AOC::D6 do
  describe 'Day 6' do
    context 'Example input' do
      subject { AOC::D6.new(File.readlines('spec/input/6_example.txt').map(&:strip)) }

      it 'parses the input correctly' do
        expect(subject.fish.length).to be 5
        expect(subject.fish[0].timer).to be 3
        expect(subject.fish[1].timer).to be 4
        expect(subject.fish[2].timer).to be 3
        expect(subject.fish[3].timer).to be 1
        expect(subject.fish[4].timer).to be 2
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

      # it 'Puzzle 2 gives correct answer' do
      #   expect(subject.p2).to eq(17_741)
      # end
    end
  end
end
