# https://leetcode.com/problems/first-missing-positive/

# Given an unsorted integer array nums, return the smallest missing positive integer.
# You must implement an algorithm that runs in O(n) time and uses constant extra space.



def first_missing_positive(nums)
  index = 0
  while index < nums.count
    current_value = nums[index]
    proper_index = current_value.pred
    if current_value > 0 && proper_index < nums.count && current_value != nums[proper_index]
      nums[proper_index], nums[index] = current_value, nums[proper_index]
    else
      index = index.succ
    end
  end
  for index in 0...nums.count
    return index.succ unless nums[index] == index.succ
  end
  return nums.count.succ
end


