# https://leetcode.com/problems/move-zeroes/

# Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.
# Note that you must do this in-place without making a copy of the array.

# Approach
#   1. Iterate over array over non-zero elements
#   2. Swap values with where pointer is at, 
#   3. Advance pointer to the next index.

# O(n)
# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def move_zeroes(nums)
  pointer = 0
  pointer.step(nums.count.pred) do |idx|
    unless nums[idx] == 0
      nums[pointer], nums[idx] = nums[idx], nums[pointer]
      pointer = pointer.succ
    end  
  end
end

