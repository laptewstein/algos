#Find the top left and bottom right coordinates of a rectangle of 0's within a matrix of 1's. It's essentially a modified version of the finding the number of island problem where you only need to dfs to the right and down.
# Ex.
# [[ 1, 1, 1, 1],
# [ 1, 0, 0, 1],
# [ 1, 0, 0, 1],
# [ 1, 1, 1, 1]]
# Expected output: [[1,1], [2,2]]

# Follow up question: Expand it so it works for any number of rectangles. I ran out of time to code this part so get throught the first part quickly. Main part of this problem is updating how results are stored and tracking what's been seen.
# Ex.
# [[0, 1, 1, 1],
# [1, 0, 0, 1],
# [1, 0, 0, 1],
# [1, 1, 1, 1]]
# Expected output: [ [[0,0],[0,0]], [[1,1], [2,2]] ]

# O(m * n)
def island_coordinates(grid)
  landmass, void = 0, 1
  coordinates = []
  rows, cols = grid.size, grid.first.size
  (0...rows).each do |r|
    (0...cols).each do |c|
      next unless grid[r][c] == landmass
      island_coordinates = [[r, c]]
      v_coord, h_coord = r, c
      
      # if exists, find out the bottom right corner
      until h_coord.succ == cols || grid[r][h_coord.succ] == void
        h_coord = h_coord.succ # advance pointer to the right
      end

      until v_coord.succ == rows || grid[v_coord.succ][c] == void
        v_coord = v_coord.succ # advance pointer to the bottom
      end

      # island might be very small and contain only one cell
      island_coordinates << [v_coord, h_coord] unless r == v_coord && c == h_coord
      coordinates << island_coordinates

      # pound with water
      (r..v_coord).each do |r_idx|
        (c..h_coord).each do |c_idx|
          grid[r_idx][c_idx] = void
        end
      end
    end
  end
  coordinates
end

matrix = [
  [1, 1, 1, 1],
  [1, 0, 0, 1],
  [1, 0, 0, 1],
  [1, 1, 1, 1]
]
puts island_coordinates(matrix).inspect
# [[ [1, 1], [2, 2] ]] # just one island

matrix = [
  [0, 0, 1, 1, 1],
  [0, 0, 1, 1, 1],
  [1, 1, 0, 1, 1],
  [1, 1, 1, 0, 0],
]
puts island_coordinates(short_matrix).inspect
# [
#   [ [0, 0], [1, 1] ], # one
#   [ [2, 2] ],         # second
#   [ [3, 3], [3, 4] ]  # third
# ]

