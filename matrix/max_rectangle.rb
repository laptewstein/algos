# Calculate  maximum rectangle area. 


class Solution
  def self.largest_rectangle_area(array)
    # extend given array with 0 ( index -1 will fetch this value)
    largest_rectangles(array << 0, -1).max
  end  

  def self.largest_rectangles(array, *stack)
    answer = []
    
    # 1. Iterate over array elements
    array.each_with_index do |current_height, index|

      puts("index #{index}: is #{current_height} less than #{array[stack.last]}? >> #{(current_height < array[stack.last]).inspect.upcase}!! :: stack #{stack}")

      #### 2. Do not calculate if current is higher or equal to previous element in array
      while array[stack.last] > current_height 
        # 3. When value < previous:
        # 3.1. pop most recent index from the stack 
        # 3.2  fetch corresponding value with this index

        # height of the rectangle
        height = array[stack.pop]

        # width of the rectangle from current index to previous index: 
        width = index - stack.last - 1 #  1 - (-1) - 1 => 1 if length 1
        answer << height * width # optionally: [previous_max_area, curent_max_area].max 
        puts("popped #{height}, stack #{stack}, #{height} * #{width} => #{answer}")
      end  
      stack << index # [-1, index .. current]
    end
    answer
  end
end

#####
puts Solution.largest_rectangle_area([2,1,5,6,2,3,2,3])
---------
# index 0: is 2 less than 0? >> FALSE!! :: stack [-1]
# index 1: is 1 less than 2? >> TRUE!! :: stack [-1, 0]
# popped 2, stack [-1], 2 * 1 => [2]
# index 2: is 5 less than 1? >> FALSE!! :: stack [-1, 1]
# index 3: is 6 less than 5? >> FALSE!! :: stack [-1, 1, 2]
# index 4: is 2 less than 6? >> TRUE!! :: stack [-1, 1, 2, 3]
# popped 6, stack [-1, 1, 2], 6 * 1 => [2, 6]
# popped 5, stack [-1, 1], 5 * 2 => [2, 6, 10]
# index 5: is 3 less than 2? >> FALSE!! :: stack [-1, 1, 4]
# index 6: is 2 less than 3? >> TRUE!! :: stack [-1, 1, 4, 5]
# popped 3, stack [-1, 1, 4], 3 * 1 => [2, 6, 10, 3]
# index 7: is 3 less than 2? >> FALSE!! :: stack [-1, 1, 4, 6]
# index 8: is 0 less than 3? >> TRUE!! :: stack [-1, 1, 4, 6, 7]
# popped 3, stack [-1, 1, 4, 6], 3 * 1 => [2, 6, 10, 3, 3]
# popped 2, stack [-1, 1, 4], 2 * 3 => [2, 6, 10, 3, 3, 6]
# popped 2, stack [-1, 1], 2 * 6 => [2, 6, 10, 3, 3, 6, 12]
# popped 1, stack [-1], 1 * 8 => [2, 6, 10, 3, 3, 6, 12, 8]
# 12
