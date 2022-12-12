# https://leetcode.com/problems/number-of-islands/

# Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

# An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.


# BFS
def num_islands(grid)
  visited = []
  islands = 0
  neighbors = [
    [-1, 0], # up    ↑
    [0, 1],  # right →
    [1, 0],  # down  ↓
    [0, -1]  # left  ←
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
          exp_r, exp_c = queue.shift
          neighbors.each do |nr, nc|
            relative_r = exp_r + nr
            relative_c = exp_c + nc
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

# instead of keeping track of visited, pound visited landmass with water
# also use cell id instead of coordinates
def num_islands(grid)
  landmass, void = '1', '0'
  islands = 0
  rows, cols = grid.size, grid.first.size
  neighbors = [
    [-1, 0], # up    ↑
    [0, 1],  # right →
    [1, 0],  # down  ↓
    [0, -1]  # left  ←
  ]
  queue = []
  (0...rows).each do |r|
    (0...cols).each do |c|
      if grid[r][c] == landmass
        islands += 1

        # explore
        queue << r * cols + c

        until queue.empty?
          id = queue.shift
          exp_r, exp_c = id / cols, id % cols

          # mark as visited
          grid[exp_r][exp_c] = void
          neighbors.each do |nr, nc|
            relative_r = exp_r + nr
            relative_c = exp_c + nc

            # skip out of bounds and water cells
            next unless relative_r > -1 && relative_r < rows
            next unless relative_c > -1 && relative_c < cols
            next unless grid[relative_r][relative_c] == landmass

            # explore neighbor's neighbors
            queue << relative_r * cols + relative_c
          end
        end
      end
    end
  end
  islands
end

