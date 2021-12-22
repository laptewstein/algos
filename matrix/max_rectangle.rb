class Solution
  def self.largest_rectangle_area(array)
    puts("Array: #{array.inspect} + [0]\n\n")
    # extend given array with 0 (index -1 will fetch this value)
    largest_rectangle_areas(array << 0, -1).max
  end  

  def self.largest_rectangle_areas(array, *index_sequence)
    areas = []
    
    # 1. Iterate over array elements
    array.each_with_index do |current_height, index|

      puts("[#{index}] #{current_height} is #{current_height < array[index_sequence.last] ? 'LOWER' : "higher"} than #{array[index_sequence.last]} (of index_sequence #{index_sequence}.last)")

      #### 2. Do not calculate if current is higher or equal to previous element in array
      while array[index_sequence.last] > current_height
        # 3. When value < previous:
        # 3.1. pop most recent index from the stack 
        # 3.2  fetch corresponding value with this index

        # height of the rectangle
        height = array[index_sequence.pop]

        # width of the rectangle from current index to previous index: 
        width = index.pred - index_sequence.last #  0 - (-1) => 1
        areas << height * width # optionally: [previous_max_area, curent_max_area].max 
        puts("[!OMG!] pop #{height} (value of last index ^), width (#{index.pred} (index) - #{index_sequence.last} (index_sequence.last)) index_sequence #{index_sequence}, #{height} * #{width} => #{areas}")
      end  
      index_sequence << index # [-1, index .. current]
      puts("[#{index}] goes into #{index_sequence}")
    end
    areas
  end
end

#####
puts Solution.largest_rectangle_area([2,1,5,6,2,3,2,3])
# Array: [2, 1, 5, 6, 2, 3, 2, 3] + [0]
# 
# [0] 2 is higher than 0 (of index_sequence [-1].last)
# [0] goes into [-1, 0]
# [1] 1 is LOWER than 2 (of index_sequence [-1, 0].last)
# [!OMG!] pop 2 (value of last index ^), width (0 (index) - -1 (index_sequence.last)) index_sequence [-1], 2 * 1 => [2]
# [1] goes into [-1, 1]
# [2] 5 is higher than 1 (of index_sequence [-1, 1].last)
# [2] goes into [-1, 1, 2]
# [3] 6 is higher than 5 (of index_sequence [-1, 1, 2].last)
# [3] goes into [-1, 1, 2, 3]
# [4] 2 is LOWER than 6 (of index_sequence [-1, 1, 2, 3].last)
# [!OMG!] pop 6 (value of last index ^), width (3 (index) - 2 (index_sequence.last)) index_sequence [-1, 1, 2], 6 * 1 => [2, 6]
# [!OMG!] pop 5 (value of last index ^), width (3 (index) - 1 (index_sequence.last)) index_sequence [-1, 1], 5 * 2 => [2, 6, 10]
# [4] goes into [-1, 1, 4]
# [5] 3 is higher than 2 (of index_sequence [-1, 1, 4].last)
# [5] goes into [-1, 1, 4, 5]
# [6] 2 is LOWER than 3 (of index_sequence [-1, 1, 4, 5].last)
# [!OMG!] pop 3 (value of last index ^), width (5 (index) - 4 (index_sequence.last)) index_sequence [-1, 1, 4], 3 * 1 => [2, 6, 10, 3]
# [6] goes into [-1, 1, 4, 6]
# [7] 3 is higher than 2 (of index_sequence [-1, 1, 4, 6].last)
# [7] goes into [-1, 1, 4, 6, 7]
# [8] 0 is LOWER than 3 (of index_sequence [-1, 1, 4, 6, 7].last)
# [!OMG!] pop 3 (value of last index ^), width (7 (index) - 6 (index_sequence.last)) index_sequence [-1, 1, 4, 6], 3 * 1 => [2, 6, 10, 3, 3]
# [!OMG!] pop 2 (value of last index ^), width (7 (index) - 4 (index_sequence.last)) index_sequence [-1, 1, 4], 2 * 3 => [2, 6, 10, 3, 3, 6]
# [!OMG!] pop 2 (value of last index ^), width (7 (index) - 1 (index_sequence.last)) index_sequence [-1, 1], 2 * 6 => [2, 6, 10, 3, 3, 6, 12]
# [!OMG!] pop 1 (value of last index ^), width (7 (index) - -1 (index_sequence.last)) index_sequence [-1], 1 * 8 => [2, 6, 10, 3, 3, 6, 12, 8]
# [8] goes into [-1, 8]
# 12
