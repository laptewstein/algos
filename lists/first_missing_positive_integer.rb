# Given an array of integers,
# find the first missing positive integer in linear time and constant space.
# In other words, find the lowest positive integer that does not exist in the array.
# The array can contain duplicates and negative numbers as well.
# You can modify the input array in-place.

# For example, the input [3, 4, -1, 1] should give 2.
# The input [1, 2, 0] should give 3.

def missing_positive(input_array)
  (1..input_array.max).detect do |elem|
    !input_array.include?(elem)
  end || input_array.max.succ
end

puts missing_positive([3, 4, -1, 1])
puts missing_positive([1, 2, 0])
