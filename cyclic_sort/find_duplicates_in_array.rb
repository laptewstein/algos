# https://leetcode.com/problems/find-all-duplicates-in-an-array/description/

# Given an integer array nums of length n where all the integers of nums are in the range [1, n] and each integer appears once or twice, return an array of all the integers that appears twice.

# You must write an algorithm that runs in O(n) time and uses only constant extra space.

def find_duplicates(nums)
  ans = []
  index = 0
  while index < nums.length
    current_value = nums[index]                  # value at current_index
    expected_spot = current_value.pred           # should be at this index, array starts with 1
    if current_value == nums[expected_spot]      # if its in correct place
      index = index.succ                         # value already in it's correct location, move to next
    else
      nums[expected_spot], nums[index] = current_value, nums[expected_spot]
    end
  end
  for index in 0...nums.length
    if nums[index] != index.succ
        ans << nums[index]
    end
  end  
  ans.sort
end
