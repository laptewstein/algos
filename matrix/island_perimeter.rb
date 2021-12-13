# You are given a map in form of a two-dimensional integer grid where 1 represents land and 0 represents water. Grid cells are connected horizontally/vertically (not diagonally). The grid is completely surrounded by water, and there is exactly one island (i.e., one or more connected land cells). The island doesn't have "lakes" (water inside that isn't connected to the water around the island). One cell is a square with side length 1. The grid is rectangular, width and height don't exceed 100. Determine the perimeter of the island.
# Example:
#
# [[0,1,0,0],
#  [1,1,1,0],
#  [0,1,0,0],
#  [1,1,0,0]]
#
# Answer: 16
# Explanation: The perimeter is the 16 yellow stripes in the image


class Solution
  # 1. The description of this problem implies there may be an "pattern" in calculating the perimeter of the islands.
  # 2. The pattern is: for every adjacent islands, two sides disappeared.
  # +--+     +--+              +--+--+
  # |  |  +  |  |     ->       |     |  # 4 + 4 - 2 = 6
  # +--+     +--+              +--+--+
  def calculate_perimeter(matrix)
    islands, neighbours = 0
    matrix.each do |row|
      row.each do |column|
        if column == 1
          islands = islands.succ # count islands
          neighbours = neighbours.succ if (i < matrix.length - 1 && matrix[i + 1][j] == 1) # neighbour BELOW
          neighbours = neighbours.succ if (j < matrix[i].length - 1 && matrix[i][j + 1] == 1) # neighbour RIGHT
        end
      end
    end
    islands * 4 - neighbours * 2
  end
end
