# https://leetcode.com/problems/search-a-2d-matrix/

=begin
Write an efficient algorithm that searches for a value target in an m x n integer matrix matrix.
This matrix has the following properties:

Integers in each row are sorted from left to right.
The first integer of each row is greater than the last integer of the previous row.
=end

# O(log n), sorted matrix in asc order
# t/f + with how many iterations
def search_matrix(matrix, target)
  rows, cols = matrix.size, matrix.first.size
  low, high = 0, (rows * cols).pred
  puts "target => #{target}"
  while low < high
    mid = low + ((high - low) / 2) # (low + high) / 2 would work until they exceed MaxInt
    return true if matrix[mid / cols][mid % cols] == target

    if matrix[mid / cols][mid % cols] > target
      high = mid.pred
    else
      low = mid.succ
    end
  end
  low == high && matrix[low / cols][low % cols] == target
end

# O(log n), sorted matrix in asc order
# t/f + with how many iterations it took to get to the target
def search_matrix(matrix, target)
  rows, cols = matrix.size, matrix.first.size
  low, high = 0, (rows * cols).pred
  iterations = 1
  while low < high
    mid = low + ((high - low) / 2) # (low + high) / 2 would work until they exceed MaxInt
    return [true, iterations] if matrix[mid / cols][mid % cols] == target

    if matrix[mid / cols][mid % cols] > target
      high = mid.pred
    else
      low = mid.succ
    end
    iterations = iterations.succ
  end
  return [false, iterations] if low > high

  [matrix[low / cols][low % cols] == target ? true : false, iterations]
end

grid = [
  [ 0,  1,  2,  3,  4],
  [ 5,  6,  7,  8,  9],
  [10, 11, 12, 13, 14],
  [15, 16, 17, 18, 19]
]

puts search_matrix(grid, 3).inspect + "\n\n"
puts search_matrix(grid, 12).inspect + "\n\n"
puts search_matrix(grid, 18).inspect + "\n\n"

puts search_matrix(grid, 35).inspect + "\n\n"
puts search_matrix(grid, 0).inspect + "\n\n"
puts search_matrix(grid, 20).inspect + "\n\n"

# target => 3
# 0-19 (mid 9) | m[1][4] = 9
# high is now idx 8
# 0-8 (mid 4) | m[0][4] = 4
# high is now idx 3
# 0-3 (mid 1) | m[0][1] = 1
# low is now idx 2
# 2-3 (mid 2) | m[0][2] = 2
# low is now idx 3
# [true, 5]

# target => 12
# 0-19 (mid 9) | m[1][4] = 9
# low is now idx 10
# 10-19 (mid 14) | m[2][4] = 14
# high is now idx 13
# 10-13 (mid 11) | m[2][1] = 11
# low is now idx 12
# 12-13 (mid 12) | m[2][2] = 12
# [true, 4]

# target => 18
# 0-19 (mid 9) | m[1][4] = 9
# low is now idx 10
# 10-19 (mid 14) | m[2][4] = 14
# low is now idx 15
# 15-19 (mid 17) | m[3][2] = 17
# low is now idx 18
# 18-19 (mid 18) | m[3][3] = 18
# [true, 4]

# target => 35
# 0-19 (mid 9) | m[1][4] = 9
# low is now idx 10
# 10-19 (mid 14) | m[2][4] = 14
# low is now idx 15
# 15-19 (mid 17) | m[3][2] = 17
# low is now idx 18
# 18-19 (mid 18) | m[3][3] = 18
# low is now idx 19
# [false, 5]

# target => 0
# 0-19 (mid 9) | m[1][4] = 9
# high is now idx 8
# 0-8 (mid 4) | m[0][4] = 4
# high is now idx 3
# 0-3 (mid 1) | m[0][1] = 1
# high is now idx 0
# [true, 4]

# target => 20
# 0-19 (mid 9) | m[1][4] = 9
# low is now idx 10
# 10-19 (mid 14) | m[2][4] = 14
# low is now idx 15
# 15-19 (mid 17) | m[3][2] = 17
# low is now idx 18
# 18-19 (mid 18) | m[3][3] = 18
# low is now idx 19
# [false, 5]
