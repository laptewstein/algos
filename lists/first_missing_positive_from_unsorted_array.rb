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

# for learning purposes,
# lets add a few print statements:
def first_missing_positive(nums)
  index = 0
  while index < nums.count
    current_value = nums[index]
    proper_index = current_value.pred
    # puts nums.inspect
    # puts "index #{index}, current_value: #{current_value}, proper_index #{proper_index}"
    if current_value > 0 && proper_index < nums.count && current_value != nums[proper_index]
      nums[proper_index], nums[index] = current_value, nums[proper_index]
    else
      # puts "incrementing index, number is either negative or at the right location"
      index = index.succ
    end
  end
  # puts nums.inspect
  for index in 0...nums.count
    return index.succ unless nums[index] == index.succ
  end
  return nums.count.succ
end

puts first_missing_positive [3,4,-1,1]

# [3, 4, -1, 1]
# index 0, current_value: 3, proper_index 2
# [-1, 4, 3, 1]
# index 0, current_value: -1, proper_index -2
# incrementing index, number is either negative or at the right location
# [-1, 4, 3, 1]
# index 1, current_value: 4, proper_index 3
# [-1, 1, 3, 4]
# index 1, current_value: 1, proper_index 0
# [1, -1, 3, 4]
# index 1, current_value: -1, proper_index -2
# incrementing index, number is either negative or at the right location
# [1, -1, 3, 4]
# index 2, current_value: 3, proper_index 2
# incrementing index, number is either negative or at the right location
# [1, -1, 3, 4]
# index 3, current_value: 4, proper_index 3
# incrementing index, number is either negative or at the right location
# [1, -1, 3, 4]

# => 2
