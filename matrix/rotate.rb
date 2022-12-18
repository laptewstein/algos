# https://leetcode.com/problems/rotate-image

# Rotate Image
# You are given an n x n 2D matrix representing an image, rotate the image by 90 degrees (clockwise).

# You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

image = [
  [1,   2,  3,  4],
  [5,   6,  7,  8],
  [9,  10, 11, 12],
  [13, 14, 15, 16],
]

# image.last.zip(*image[0...-1].reverse)
def rotate(matrix)
  left, right = 0, matrix.size.pred
  while left < right
    top, bottom = left, right
    (0...(right-left)).each do |offset|
      # save one corner
      top_left = matrix[top][left + offset]

      # move bottom left to top left
      matrix[top][left + offset] = matrix[bottom - offset][left]

      # move bottom right to bottom left
      matrix[bottom - offset][left] = matrix[bottom][right - offset]

      # move top right to bottom right
      matrix[bottom][right - offset] = matrix[top + offset][right]

      # move top left to top right
      matrix[top + offset][right] = top_left
    end
    left  = left.succ
    right = right.pred
  end
  matrix
end

puts rotate(Marshal.load(Marshal.dump(image))).inspect
# [
#   [13, 9,  5, 1],
#   [14, 10, 6, 2],
#   [15, 11, 7, 3],
#   [16, 12, 8, 4]
# ]


# 2) =====================
# rotate ANY RECTANGLE-shaped matrix
def rotate_image(mat)
  rows, cols = mat.size, mat.first.size
  m = Array.new(cols) { Array.new(rows) }
  for r in 0...rows   # row becomes column
    for c in 0...cols # column becomes row
      new_col = (r - rows.pred).abs
      m[c][new_col] = mat[r][c]
    end
  end
  m
end

rectangle = [
  [1,   2,  3,  4,  5,  6],
  [7,   8,  9,  10, 11, 12],
  [13,  14, 15, 16, 17, 18],
  [19,  20, 21, 22, 23, 24],
]
puts rotate_image(Marshal.load(Marshal.dump(rectangle))).inspect # deep copy of ogirinal 2D array
# [
#   [19, 13, 7, 1],
#   [20, 14, 8, 2],
#   [21, 15, 9, 3],
#   [22, 16, 10, 4],
#   [23, 17, 11, 5],
#   [24, 18, 12, 6]
# ]


# 3) using extra space =====================
m = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]

# read left-to-right, top-to-botttom
# store values in 1D array
# then use positional index to access 1D values
# and transfer back to orig matrix
def rotate_image(mat)
  rows, cols = mat.size, mat.first.size
  l = []
  for c in 0...cols
    for r in rows.pred.downto(0)
      l << mat[r][c]
    end
  end
  idx = 0 # alternative: array.shift
  for r in 0...rows
    for c in 0...cols
      mat[r][c] = l[idx]
      idx = idx.succ
    end
  end
  mat
end

puts rotate_image(Marshal.load(Marshal.dump(m))).inspect # deep copy of ogirinal 2D array


# read left to right, bottom-up
# store left-to-right, top-to-bottom
def rotate_image(mat)
  rows, cols = mat.size, mat.first.size
  m = Array.new(cols) { Array.new(rows) }
  for c, rr in (0...cols).zip(0...rows)              # column becomes row
    for r, cc in (rows.pred.downto(0)).zip(0...cols) # row becomes column
      m[rr][cc] = mat[r][c]
    end
  end
  m
end

puts rotate_image(Marshal.load(Marshal.dump(m))).inspect # deep copy of ogirinal 2D array

