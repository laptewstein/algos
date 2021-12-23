# Given an array of non-negative integers, each one representing the histogram's bar height where the width of each bar is 1, 
# return the area of the largest rectangle in the histogram.

class Solution
  def self.largest_rectangle_area(array)
    puts("Array: #{array.inspect} + [0]\n\n")
    # extend given array with 0 (index -1 will fetch this value)
    areas = largest_rectangle_areas(array << 0, -1)
    puts("Max areas discovered: #{areas.inspect}")
    areas.max
  end

  def self.largest_rectangle_areas(array, *index_sequence)
    areas = []
    array.each_with_index do |current_height, index|

      # When current element < previous (or, previously seen):
      #   - pop an index from the index sequence stack
      #   - calculate current rectangle area spanning 1+ bars, by multiplying
      #      (height) element's value
      #      (width) by the index offset from current index

      while current_height < array[index_sequence.last]
        height = array[index_sequence.pop]
        width = index.pred - index_sequence.last #  0 - (-1) => 1
        areas << height * width
      end  
      index_sequence << index
    end
    areas
  end
end

puts Solution.largest_rectangle_area([2,1,5,6,2,3,2,3])

# Array: [2, 1, 5, 6, 2, 3, 2, 3] + [0]
# 
# [0] 2 is higher than 0 (of index_sequence [-1].last)
# [0] hve been referenced in the sequence: [-1, 0]
# [1] 1 is LOWER than 2 (of index_sequence [-1, 0].last)
# [!OMG!] index_sequence.pop of 2, width (0 (index) - -1 (index_sequence.last)) index_sequence [-1], 2 * 1 => [2]
# [1] hve been referenced in the sequence: [-1, 1]
# [2] 5 is higher than 1 (of index_sequence [-1, 1].last)
# [2] hve been referenced in the sequence: [-1, 1, 2]
# [3] 6 is higher than 5 (of index_sequence [-1, 1, 2].last)
# [3] hve been referenced in the sequence: [-1, 1, 2, 3]
# [4] 2 is LOWER than 6 (of index_sequence [-1, 1, 2, 3].last)
# [!OMG!] index_sequence.pop of 6, width (3 (index) - 2 (index_sequence.last)) index_sequence [-1, 1, 2], 6 * 1 => [2, 6]
# [!OMG!] index_sequence.pop of 5, width (3 (index) - 1 (index_sequence.last)) index_sequence [-1, 1], 5 * 2 => [2, 6, 10]
# [4] hve been referenced in the sequence: [-1, 1, 4]
# [5] 3 is higher than 2 (of index_sequence [-1, 1, 4].last)
# [5] hve been referenced in the sequence: [-1, 1, 4, 5]
# [6] 2 is LOWER than 3 (of index_sequence [-1, 1, 4, 5].last)
# [!OMG!] index_sequence.pop of 3, width (5 (index) - 4 (index_sequence.last)) index_sequence [-1, 1, 4], 3 * 1 => [2, 6, 10, 3]
# [6] hve been referenced in the sequence: [-1, 1, 4, 6]
# [7] 3 is higher than 2 (of index_sequence [-1, 1, 4, 6].last)
# [7] hve been referenced in the sequence: [-1, 1, 4, 6, 7]
# [8] 0 is LOWER than 3 (of index_sequence [-1, 1, 4, 6, 7].last)
# [!OMG!] index_sequence.pop of 3, width (7 (index) - 6 (index_sequence.last)) index_sequence [-1, 1, 4, 6], 3 * 1 => [2, 6, 10, 3, 3]
# [!OMG!] index_sequence.pop of 2, width (7 (index) - 4 (index_sequence.last)) index_sequence [-1, 1, 4], 2 * 3 => [2, 6, 10, 3, 3, 6]
# [!OMG!] index_sequence.pop of 2, width (7 (index) - 1 (index_sequence.last)) index_sequence [-1, 1], 2 * 6 => [2, 6, 10, 3, 3, 6, 12]
# [!OMG!] index_sequence.pop of 1, width (7 (index) - -1 (index_sequence.last)) index_sequence [-1], 1 * 8 => [2, 6, 10, 3, 3, 6, 12, 8]
# [8] hve been referenced in the sequence: [-1, 8]
# Max areas discovered: [2, 6, 10, 3, 3, 6, 12, 8]
# 12
