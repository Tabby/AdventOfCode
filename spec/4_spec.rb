# frozen_string_literal: true

require_relative '../4'

describe AOC::D4 do
  describe 'Day 4' do
    context 'Example input' do
      subject { AOC::D4.new(File.readlines('spec/input/4_example.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer with example input' do
        expect(subject.p1).to eq(4512)
      end

      it 'Puzzle 2 gives correct answer with example input' do
        expect(subject.p2).to eq(1924)
      end
    end

    context 'Real input' do
      subject { AOC::D4.new(File.readlines('spec/input/4.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer with real input' do
        expect(subject.p1()).to eq(14_093)
      end

      it 'Puzzle 2 gives correct answer with real input' do
        expect(subject.p2()).to eq(17_388)
      end
    end
  end
end

describe AOC::BingoBoard do
  subject do
    AOC::BingoBoard.new([
                          [14, 21, 17, 24, 4],
                          [10, 16, 15, 9, 19],
                          [18, 8, 23, 26, 20],
                          [22, 11, 13, 6, 5],
                          [2, 0, 12, 3, 7]
    ])
  end

  context 'the board' do
    it 'is initialised correctly' do
      expect(subject.numbers.find { |item| item[:x] == 0 && item[:y] == 0 }[:number]).to be 14
      expect(subject.numbers.find { |item| item[:x] == 1 && item[:y] == 1 }[:number]).to be 16
      expect(subject.numbers.find { |item| item[:x] == 2 && item[:y] == 2 }[:number]).to be 23
      expect(subject.numbers.find { |item| item[:x] == 3 && item[:y] == 3 }[:number]).to be 6
      expect(subject.numbers.find { |item| item[:x] == 4 && item[:y] == 4 }[:number]).to be 7
    end

    it 'is not considered to have won when no numbers are called' do
      expect(subject.won?).to be false
    end

    it 'marks called numbers correctly' do
      expect(subject.numbers.select { |item| item[:called] }).to be_empty
      expect(subject.mark(22)).to be false
      expect(subject.numbers.select { |item| item[:called] }.length).to be 1
    end

    it 'wins if a row is fully marked' do
      expect(subject.numbers.select { |item| item[:called] }).to be_empty
      expect(subject.mark(18)).to be false
      expect(subject.mark(26)).to be false
      expect(subject.mark(20)).to be false
      expect(subject.mark(8)).to be false
      expect(subject.mark(23)).to be true
      expect(subject.winning_line).to match_array [18, 8, 23, 26, 20]
    end

    it 'wins if a column is fully marked' do
      expect(subject.numbers.select { |item| item[:called] }).to be_empty
      expect(subject.mark(3)).to be false
      expect(subject.mark(9)).to be false
      expect(subject.mark(24)).to be false
      expect(subject.mark(6)).to be false
      expect(subject.mark(26)).to be true
      expect(subject.winning_line).to match_array [24, 9, 26, 6, 3]
    end
  end
end
