# frozen_string_literal: true

require_relative '../5'

describe AOC::D5 do
  describe 'Day 5' do
    context 'Example input' do
      subject { AOC::D5.new(File.readlines('spec/input/5_example.txt').map(&:strip)) }

      it 'parses the input correctly' do
        expect(subject.lines.length).to be 10
        expect(subject.lines.first).to match(
          start: { x: 0, y: 9 },
          finish: { x: 5, y: 9 }
        )
        expect(subject.width).to be 9
        expect(subject.height).to be 9
      end

      it 'determines horizontal and vertical lines correctly' do
        expect(subject.horizontal_or_vertical?(subject.lines[0])).to be true
        expect(subject.horizontal_or_vertical?(subject.lines[1])).to be false
        expect(subject.horizontal_or_vertical?(subject.lines[2])).to be true
        expect(subject.horizontal_or_vertical?(subject.lines[3])).to be true
        expect(subject.horizontal_or_vertical?(subject.lines[4])).to be true
        expect(subject.horizontal_or_vertical?(subject.lines[5])).to be false
        expect(subject.horizontal_or_vertical?(subject.lines[6])).to be true
        expect(subject.horizontal_or_vertical?(subject.lines[7])).to be true
        expect(subject.horizontal_or_vertical?(subject.lines[8])).to be false
        expect(subject.horizontal_or_vertical?(subject.lines[9])).to be false
      end

      it 'gets points from horizontal and vertical lines correctly' do
        expect(subject.get_points_from_line(subject.lines[0])).to match_array(
          [{ x: 0, y: 9 }, { x: 1, y: 9 }, { x: 2, y: 9 }, { x: 3, y: 9 }, { x: 4, y: 9 }, { x: 5, y: 9 }]
        )
        expect(subject.get_points_from_line(subject.lines[2])).to match_array(
          [
            { x: 9, y: 4 }, { x: 8, y: 4 }, { x: 7, y: 4 }, { x: 6, y: 4 },
            { x: 5, y: 4 }, { x: 4, y: 4 }, { x: 3, y: 4 }
          ]
        )
        expect(subject.get_points_from_line(subject.lines[3])).to match_array(
          [{ x: 2, y: 2 }, { x: 2, y: 1 }]
        )
        expect(subject.get_points_from_line(subject.lines[4])).to match_array(
          [{ x: 7, y: 0 }, { x: 7, y: 1 }, { x: 7, y: 2 }, { x: 7, y: 3 }, { x: 7, y: 4 }]
        )
        expect(subject.get_points_from_line(subject.lines[6])).to match_array(
          [{ x: 0, y: 9 }, { x: 1, y: 9 }, { x: 2, y: 9 }]
        )
        expect(subject.get_points_from_line(subject.lines[7])).to match_array(
          [{ x: 3, y: 4 }, { x: 2, y: 4 }, { x: 1, y: 4 }]
        )
      end

      it 'gets points from diagonal lines correctly' do
        expect(subject.get_points_from_line(subject.lines[1])).to match_array(
          [
            { x: 8, y: 0 }, { x: 7, y: 1 }, { x: 6, y: 2 }, { x: 5, y: 3 }, { x: 4, y: 4 },
            { x: 3, y: 5 }, { x: 2, y: 6 }, { x: 1, y: 7 }, { x: 0, y: 8 }
          ]
        )
        expect(subject.get_points_from_line(subject.lines[5])).to match_array(
          [{ x: 6, y: 4 }, { x: 5, y: 3 }, { x: 4, y: 2 }, { x: 3, y: 1 }, { x: 2, y: 0 }]
        )
        expect(subject.get_points_from_line(subject.lines[8])).to match_array(
          [
            { x: 0, y: 0 }, { x: 1, y: 1 }, { x: 2, y: 2 }, { x: 3, y: 3 }, { x: 4, y: 4 },
            { x: 5, y: 5 }, { x: 6, y: 6 }, { x: 7, y: 7 }, { x: 8, y: 8 }
          ]
        )
        expect(subject.get_points_from_line(subject.lines[9])).to match_array(
          [{ x: 5, y: 5 }, { x: 6, y: 4 }, { x: 7, y: 3 }, { x: 8, y: 2 }]
        )
      end

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq(5)
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq(12)
      end
    end

    context 'Real input' do
      subject { AOC::D5.new(File.readlines('spec/input/5.txt').map(&:strip)) }

      it 'Puzzle 1 gives correct answer' do
        expect(subject.p1).to eq(5690)
      end

      it 'Puzzle 2 gives correct answer' do
        expect(subject.p2).to eq(17_741)
      end
    end
  end
end
