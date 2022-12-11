# frozen_string_literal: true

require_relative '../6'

describe AOC::D6 do
  describe 'Day 6' do
    context 'Example input' do
      subject { AOC::D6.new(File.readlines('spec/input/6_example.txt').map(&:strip)) }

      it 'parses the input correctly' do
        raise NotImplementedError
      end

      it 'Puzzle 1 gives correct answer' do
        raise NotImplementedError
        # expect(subject.p1).to eq 5934
      end

      it 'Puzzle 2 gives correct answer' do
        raise NotImplementedError
        # expect(subject.p2).to eq 26_984_457_539
      end
    end

    context 'Real input' do
      subject { AOC::D6.new(File.readlines('spec/input/6.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        raise NotImplementedError
        # expect(subject.p1).to eq 352_195
      end

      it 'Puzzle 2 gives correct answer' do
        raise NotImplementedError
        # expect(subject.p2).to eq 1_600_306_001_288
      end
    end
  end
end
