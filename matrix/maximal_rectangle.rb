# https://leetcode.com/problems/maximal-rectangle/
# Given a rows x cols binary matrix filled with 0's and 1's, find the largest rectangle containing only 1's and return its area.


def maximal_rectangle(matrix)
  printer = lambda do |grid|
    width = grid.flatten.max.to_s.size + 2
    puts grid.map { |r| r.map { |c| c.to_s.rjust(width) }.join }
  end

  occupied = "1"
  max = nil
  # build heights table
  rows, cols = matrix.count, matrix.first.count
  heights = Array.new(rows) { Array.new(cols) }
  # add up numbers from second row and below
  # in first row the job is done for us (but we still have to convert string values into integers)
  (0...rows).each do |r|
    (0...cols).each do |c|
      heights[r][c] =
        if matrix[r][c] == occupied
          if r > 0
            heights[r.pred][c].succ
          else
            matrix[r][c].to_i
          end
        else
          0
        end
    end
  end
  printer.call matrix
  puts "-" * 17
  printer.call heights
  puts "=" * 17
  # now that we have level histograms, lets find out the max rectagle per level
  max_rectangle_area(heights.sort_by(&:sum).last)
end


# When current element < previous (or, previously seen):
#   - pop an index from the index sequence stack
#   - calculate current rectangle area spanning 1+ bars, by multiplying
#      (height) element's value
#      (width) by the index offset from current index
def max_rectangle_area(histogram)
  stack = [-1]
  histogram << 0
  max = histogram.first
  (0...histogram.size).each do |idx|
    while histogram[idx] < histogram[stack.last]
      height = histogram[stack.pop]
      width = idx.pred - stack.last
      max = height * width if height * width > max
    end
    stack << idx
  end
  max
end

matrix = [
  ["1", "0", "1", "0", "0"],
  ["1", "0", "1", "1", "1"],
  ["1", "1", "1", "1", "1"],
  ["1", "0", "0", "1", "0"]
]
puts maximal_rectangle matrix

#   1  0  1  0  0
#   1  0  1  1  1
#   1  1  1  1  1
#   1  0  0  1  0
# -----------------
#   1  0  1  0  0
#   2  0  2  1  1
#   3  1  3  2  2 # this
#   4  0  0  3  0
# =================
# => 6
