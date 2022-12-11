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


# using left lesser, right lesser, and width arrays which keep reference to boundaries and max width of each height
def max_rectangle_area(histogram)
  return 0 if histogram.empty?

  puts ">> " + histogram.inspect # [ 3, 1, 3, 2, 2]
  histogram_size = histogram.size
  out_of_bound = 0.pred

  # initialize arrays with Out-Of-Bounds pointers
  left  = Array.new(histogram_size) { out_of_bound }   # first index - 1
  right = Array.new(histogram_size) { histogram_size } # last index + 1

  # 1) For every element, find the left boundary (smaller element than current) if it exists
  (1...histogram_size).each do |idx|
    left_idx = idx.pred

    # keep going left to detect lower previous height
    until left_idx == out_of_bound || histogram[left_idx] < histogram[idx]
      # left_idx = left[left_idx]
      left_idx = left_idx.pred
    end
    left[idx] = left_idx
  end

  # 2) For every element, find the right boundary (smaller element than current) if it exists
  (histogram_size - 2).step(0, -1).each do |idx| # from n-1 to 0 with step 1
    right_idx = idx.succ
    until right_idx == histogram_size || histogram[idx] > histogram[right_idx]
      # right_idx = right[right_idx]
      right_idx = right_idx.succ
    end
    right[idx] = right_idx
  end

  puts "r: " + right.inspect # [ 1,  5, 3, 5, 5]
  puts "l: " + left.inspect  # [-1, -1, 1, 1, 1]

  # 3) Calculate max area by taking element as the height,
  # and width as difference between left and right boundaries

  # (-) a: ruby-way
  # widths = (0...histogram_size).map { |idx| right[idx].pred - left[idx] }  # [1, 5, 1, 3, 3]
  # widths.zip(heights).map {|r| r.inject(:*) }.max

  # (+) b: traditional way, sort of (or comply with "max = local_max if max < local_max")
  widths = []
  maximal_rectangles = (0...histogram_size).map do |idx|
    width = right[idx].pred - left[idx]
    widths << width
    width * histogram[idx]
  end

  puts "w " + widths.inspect

  maximal_rectangles.max
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
#   3  1  3  2  2
#   4  0  0  3  0
# =================
# >> [3, 1, 3, 2, 2]
# r: [1, 5, 3, 5, 5]
# l: [-1, -1, 1, 1, 1]
# w  [1, 5, 1, 3, 3]
# => 6
