# https://leetcode.com/problems/count-submatrices-with-all-ones

# Given an m x n binary matrix mat, return the number of submatrices that have all ones.

# Input: 
# mat = [
#  [1,0,1],
#  [1,1,0],
#  [1,1,0] 
# ]

# Output: 13
# Explanation: 
# There are 6 rectangles of side 1x1.
# There are 2 rectangles of side 1x2.
# There are 3 rectangles of side 2x1.
# There is 1 rectangle of side 2x2. 
# There is 1 rectangle of side 3x1.
# Total number of rectangles = 6 + 2 + 3 + 1 + 1 = 13.

def count_submatrices(matrix)
  rows, cols = matrix.size, matrix.first.size
  widths = Array.new(rows) { Array.new(cols, 0) }

  (0...rows).each do |r|
    # calculate widths for each row (horizontal histograms)
    (0...cols).each do |c|
      if matrix[r][c] > 0
        widths[r][c] = matrix[r][c]
        widths[r][c] += widths[r][c.pred] if c > 0
      end
    end

    # alterntively, we can start counting widths from right to left
    # cols.pred.step(0, -1).each do |c|
    #   if matrix[r][c] > 0
    #     widths[r][c] = matrix[r][c]
    #     widths[r][c] += widths[r][c.succ] unless c == cols.pred
    #   end
    # end
  end

  puts widths.inspect

  count = 0
  (0...rows).each do |r|
    (0...cols).each do |c|
      lowest_row_value_seen = cols # each cell * 1 => cols
      (r...rows).each do |subset_row|
        lowest_row_value_seen = widths[subset_row][c] if widths[subset_row][c] < lowest_row_value_seen
        count += lowest_row_value_seen
      end
    end
  end
  count
end

matrix = [
  [1, 0, 1],
  [1, 1, 0],
  [1, 1, 0]
]
puts count_submatrices(matrix)
# [[1, 0, 1], [2, 1, 0], [2, 1, 0]]
# => 13

# how its buiit?
# widths (from right to left)
# [
#   [1, 0, 1],
#   [1, 2, 0],
#   [1, 2, 0]
# ]

# [0][0], column_lowest_row 3, k_row 0, widths[k_row][c] 1
# 0  + 1
# [0][0], column_lowest_row 1, k_row 1, widths[k_row][c] 1
# 1  + 1
# [0][0], column_lowest_row 1, k_row 2, widths[k_row][c] 1
# 2  + 1

# [0][1], column_lowest_row 3, k_row 0, widths[k_row][c] 0
# 3  + 0
# [0][1], column_lowest_row 0, k_row 1, widths[k_row][c] 2
# 3  + 0
# [0][1], column_lowest_row 0, k_row 2, widths[k_row][c] 2
# 3  + 0

# [0][2], column_lowest_row 3, k_row 0, widths[k_row][c] 1
# 3  + 1
# [0][2], column_lowest_row 1, k_row 1, widths[k_row][c] 0
# 4  + 0
# [0][2], column_lowest_row 0, k_row 2, widths[k_row][c] 0
# 4  + 0
# ^^^^^^^^^^^^^^ END OF first pass, all 3 rows

# [1][0], column_lowest_row 3, k_row 1, widths[k_row][c] 1
# 4  + 1
# [1][0], column_lowest_row 2, k_row 2, widths[k_row][c] 1
# 5  + 1

# [1][1], column_lowest_row 3, k_row 1, widths[k_row][c] 2
# 6  + 2
# [1][1], column_lowest_row 1, k_row 2, widths[k_row][c] 2
# 8  + 2

# [1][2], column_lowest_row 3, k_row 1, widths[k_row][c] 0
# 10  + 0
# [1][2], column_lowest_row 0, k_row 2, widths[k_row][c] 0
# 10  + 0
# ^^^^^^^^^^^^^^ END OF second pass, 2 bottom rows

# [2][0], column_lowest_row 3, k_row 2, widths[k_row][c] 1
# 10  + 1
# [2][1], column_lowest_row 3, k_row 2, widths[k_row][c] 2
# 11  + 2
# [2][2], column_lowest_row 3, k_row 2, widths[k_row][c] 0
# 13  + 0
# ^^^^^^^^^^^^^^ END OF last pass, last row

# => 13 made of:
# =============
#  [1, 0, 1,          # first pass (all row mins)
#   1, 0, 0,
#   1, 0, 0] => (4) +

#  [1, 2, 0           # bottom two row minimums
#   1, 2, 0] => (6) +

#  [1, 2, 0] => (3)   # last row entirely (only one element in each row)
# =============

# ------------------------
# just for reference, heights for this matrix are:
# [
#   [1, 0, 1],
#   [2, 1, 0],
#   [3, 2, 0]
# ]

