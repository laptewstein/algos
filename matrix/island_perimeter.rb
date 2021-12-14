# You are given a map in form of a two-dimensional integer grid where 1 represents land and 0 represents water. 
# Grid cells are connected horizontally/vertically (not diagonally). 
# The grid is completely surrounded by water, and there is exactly one island (i.e., one or more connected land cells). 
# The island doesn't have "lakes" (water inside that isn't connected to the water around the island). 
# One cell is a square with side length 1. 
# The grid is rectangular, width and height don't exceed 100. 
#
# !!!! Determine the perimeter of the island. !!!!
#
# Example:
# [[0,1,0,0],
#  [1,1,1,0],
#  [0,1,0,0],
#  [1,1,0,0]]
#
# Answer: 16
# Explanation: The perimeter is the 16 yellow stripes in the image

# There is a "pattern" in calculating the perimeter of the islands.
# Two joint sides disappear between every adjacent islands.
# +--+   +--+    +--+--+
# |  | + |  | -> |     | # 4 + 4 - 2 = 6
# +--+   +--+    +--+--+

class Solution
  def self.calculate_perimeter(matrix, land = 1)
    islands, neighbours = [[], []]
    matrix.each_with_index do |row, vertical_index|
      is_bottom_row = vertical_index == matrix.size.pred
      row.each_with_index do |value, horizontal_index|
        if value == land
          islands << land
          is_last_column = horizontal_index == row.size.pred
          # neighbour BELOW
          neighbor_below_is_land = matrix[vertical_index.next][horizontal_index] == land unless is_bottom_row
          neighbours << land if neighbor_below_is_land
          # neighbour RIGHT
          neighbor_right_is_land = row[horizontal_index.next] == land unless is_last_column
          neighbours << land if neighbor_right_is_land
        end
      end
    end
    islands.count * 4 - neighbours.count * 2
  end
end

puts Solution.calculate_perimeter([[0,1,0,0], [1,1,1,0], [0,1,0,0], [1,1,0,0]])
