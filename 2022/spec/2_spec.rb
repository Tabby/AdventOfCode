# frozen_string_literal: true

require_relative '../2'

describe AOC::D2 do
  describe 'Day 2' do
    subject do
      input = File.read(filename).split("\n").map do |line|
        labels = line.split(' ')
        {
          them: labels[0],
          us: labels[1]
        }
      end
      AOC::D2.new(input)
    end

    context 'Example input' do
      let(:filename) { 'spec/input/2_example.txt' }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq 15
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq 12
      end
    end

    context 'Real input' do
      let(:filename) { 'spec/input/2.txt' }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq 14_297
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq 10_498
      end
    end
  end
end
