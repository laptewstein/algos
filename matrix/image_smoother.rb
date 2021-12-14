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

  def self.image_smoother(matrix):
    # processed_matrix = [[]*len_cols for _ in range(len_rows)]
    row_count    = matrix.size
    column_count = matrix[0].size
    matrix.each_with_index do |row, horizontal_index|
      row.each_with_index do |cell_value, vertical_index|
        sum_all_cell_neighbours, neighbour_count = [0, 0]
        NEIGHBOURS.each do |relative_x, relative_y|
          neighbour_x_index = relative_x + horizontal_index
          neighbour_y_index = relative_y + vertical_index
          next unless matrix[neighbour_x_index][neighbour_y_index] # safe itemgetter
          sum_all_cell_neighbours += matrix[neighbour_x_index][neighbour_y_index]
          neighbour_count = neighbour_count.next 
        processed_matrix[horizontal_index][vertical_index] = sum_all_cell_neighbours // neighbour_count
    return processed_matrix

