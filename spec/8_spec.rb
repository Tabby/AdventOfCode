# frozen_string_literal: true

require_relative '../8'

describe AOC::D8 do
  describe 'Day 8' do
    context 'Short example input' do
      line = 'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf'
      subject { AOC::D8.new([line].map(&:strip)) }

      it 'parses the input correctly' do
        expect(subject.lines).to match_array(
          [
            patterns: [
              Set.new(%w[a c e d g f b]),
              Set.new(%w[c d f b e]),
              Set.new(%w[g c d f a]),
              Set.new(%w[f b c a d]),
              Set.new(%w[d a b]),
              Set.new(%w[c e f a b d]),
              Set.new(%w[c d f g e b]),
              Set.new(%w[e a f b]),
              Set.new(%w[c a g e d b]),
              Set.new(%w[a b])
            ],
            output: [
              Set.new(%w[c d f e b]),
              Set.new(%w[f c a d b]),
              Set.new(%w[c d f e b]),
              Set.new(%w[c d b a f])
            ]
          ]
        )
      end

      it 'Decodes digits' do
        expect(subject.decode_digits(subject.lines[0])).to match_array(
          [
            Set.new('cagedb'.split('')),
            Set.new('ab'.split('')),
            Set.new('gcdfa'.split('')),
            Set.new('fbcad'.split('')),
            Set.new('eafb'.split('')),
            Set.new('cdfbe'.split('')),
            Set.new('cdfgeb'.split('')),
            Set.new('dab'.split('')),
            Set.new('acedgfb'.split('')),
            Set.new('cefabd'.split(''))
          ]
        )
      end
    end

    context 'Example input' do
      subject { AOC::D8.new(File.readlines('spec/input/8_example.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq 26
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq 61_229
      end
    end

    context 'Real input' do
      subject { AOC::D8.new(File.readlines('spec/input/8.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq 274
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq 1_012_089
      end
    end
  end
end
