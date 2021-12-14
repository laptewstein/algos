# Given a 2D integer matrix M representing the gray scale of an image. Smoother the image. 
# Make the grayscale (0-255) of each cell to become the average (rounding down) of all the 8 surrounding cells + self. 
# If cell has less than 8 surrounding cells, then use as many as possible can.

# Example:
# Input: img = [[100,200,100],[200,50,200],[100,200,100]]
# Output: [[137,141,137],[141,138,141],[137,141,137]]
# Explanation:
# For the points (0,0), (0,2), (2,0), (2,2): floor((100+200+200+50)/4) = floor(137.5) = 137
# For the points (0,1), (1,0), (1,2), (2,1): floor((200+200+50+200+100+100)/6) = floor(141.666667) = 141
# For the point (1,1): floor((50+200+200+200+200+100+100+100+100)/9) = floor(138.888889) = 138

class Solution
  NEIGHBOURS = [ 
    [-1, -1], [-1, 0], [-1, 1], 
    [ 0, -1], [ 0, 0], [ 0, 1], 
    [ 1, -1], [ 1, 0], [ 1, 1]].freeze

  def self.image_smoother(matrix)
    row_count        = matrix.size
    processed_matrix = (0...row_count).map { Array.new }
    matrix.each_with_index do |row, horizontal_index|
      row.each_with_index do |_, vertical_index|
        sum_all_cell_neighbours, neighbour_count = [0, 0]
        NEIGHBOURS.each do |relative_x, relative_y|
          neighbour_x_index = relative_x + horizontal_index
          neighbour_y_index = relative_y + vertical_index
          # negative index in ruby array means start counting from the end
          # we need to access the values by index therefore we need to ignore negative indexes explicitly
          next if neighbour_x_index < 0 || neighbour_y_index < 0
          neighbour_cell_value =  matrix.dig(neighbour_x_index, neighbour_y_index)
          # indexes outside of max row.size fetch no values and need to be filtered out 
          next unless neighbour_cell_value
          sum_all_cell_neighbours += neighbour_cell_value
          neighbour_count = neighbour_count.next 
        end
        processed_matrix[horizontal_index] << sum_all_cell_neighbours / neighbour_count
      end
    end  
    processed_matrix
  end
end

smoothered_matrix = Solution.image_smoother([[100,200,100],[200,50,200],[100,200,100]])
puts smoothered_matrix.inspect
# [[137, 141, 137], [141, 138, 141], [137, 141, 137]]
