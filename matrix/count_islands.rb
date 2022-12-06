# https://leetcode.com/problems/number-of-islands/

# Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

# An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.


# BFS
def num_islands(grid)
  visited = []
  islands = 0
  neighbors = [
    [-1, 0],
    [0, 1],
    [1, 0],
    [0, -1]
  ]
  rows, cols = grid.size, grid.first.size
  queue = []
  (0...rows).each do |r|
    (0...cols).each do |c|
      if grid[r][c] == '1' && !visited.include?([r, c])
        islands += 1

        # exploration
        queue << [r, c]
        visited << [r, c]

        until queue.empty?
          r, c = queue.shift
          neighbors.each do |nr, nc|
            relative_r = r + nr
            relative_c = c + nc
            # out of bounds?
            next unless relative_r > -1 && relative_r < rows
            next unless relative_c > -1 && relative_c < cols
            # already explored?
            next if visited.include?([relative_r, relative_c])
            next unless grid[relative_r][relative_c] == '1'

            visited << [relative_r, relative_c]
            queue << [relative_r, relative_c]
          end
        end
      end
    end
  end
  islands
end

matrix = [
  ["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","0"],
  ["0","0","0","0","0"]
]
puts num_islands(matrix) == 1
