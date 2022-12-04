# https://leetcode.com/problems/find-all-duplicates-in-an-array/
# Find All Duplicates in an Array

# Given an integer array nums of length n where all the integers of nums are in the range [1, n] and each integer appears once or twice, return an array of all the integers that appears twice.

# You must write an algorithm that runs in O(n) time and uses only constant extra space.

# Strategy: 
#   (1) Loop through the array
#   (2) For each element, find array[absolute(array[i])] in the array and set its value to negative if positive
#   (3) If in step 2 we see a negative number, element (index reference) in the array is a duplicate.

def find_duplicates(list)
  list.select do |index_pointer|
    # array indexes start from 0 but pointers are <1 to n>
    element_at_index = list[index_pointer.abs.pred]
    if element_at_index > 0
      # reference is positive so let's negate it (signify that we have seen it)
      list[index_pointer.abs.pred] *= -1
      false
    else
      # element is negative: previously we have visited this element
      # current <index_pointer> is a duplicate reference
      true
    end
  end.map &:abs
end

nums = [4, 3, 2, 7, 8, 2, 3, 1]

puts find_duplicates(nums).inspect

# [4, 3, 2, 7, 8, 2, 3, 1]
# index_pointer: 4, points at 7. Marking 7 as visited: [4, 3, 2, -7, 8, 2, 3, 1]
# index_pointer: 3, points at 2. Marking 2 as visited: [4, 3, -2, -7, 8, 2, 3, 1]
# index_pointer: -2, points at 3. Marking 3 as visited: [4, -3, -2, -7, 8, 2, 3, 1]
# index_pointer: -7, points at 3. Marking 3 as visited: [4, -3, -2, -7, 8, 2, -3, 1]
# index_pointer: 8, points at 1. Marking 1 as visited: [4, -3, -2, -7, 8, 2, -3, -1]
# index_pointer 2 is a duplicate pointer to -3 which has been visited before
# index_pointer -3 is a duplicate pointer to -2 which has been visited before
# index_pointer: -1, points at 4. Marking 4 as visited: [-4, -3, -2, -7, 8, 2, -3, -1]

# Output:  [2, 3]

