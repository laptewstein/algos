# https://leetcode.com/problems/first-missing-positive/

# Given an unsorted integer array nums, return the smallest missing positive integer.
# You must implement an algorithm that runs in O(n) time and uses constant extra space.

# Time Complexity: O(n), only two traversals are needed.
# Space complexity: O(1), no extra space is needed
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

# alternative implementation, same idea
def first_missing_positive(nums)
  for index in 0...nums.count
    # puts "index #{index}, nums: #{nums.inspect}"
    while nums[index] > 0 && nums[index].pred < nums.count && nums[index] != nums[nums[index].pred]
      nums[nums[index].pred], nums[index] = nums[index], nums[nums[index].pred]
      # puts ">> nums: #{nums.inspect}"
    end
    # puts "incrementing index, number is either negative or at the right location"
  end
  # puts nums.inspect
  for index in 0...nums.count
    return index.succ unless nums[index] == index.succ
  end
  return nums.count.succ
end

puts first_missing_positive [3, 4, -1, 1]

# index 0, nums: [3, 4, -1, 1]
# >> nums: [-1, 4, 3, 1]
# incrementing index, number is either negative or at the right location

# index 1, nums: [-1, 4, 3, 1]
# >> nums: [-1, 1, 3, 4]
# >> nums: [1, -1, 3, 4]
# incrementing index, number is either negative or at the right location

# index 2, nums: [1, -1, 3, 4]
# incrementing index, number is either negative or at the right location

# index 3, nums: [1, -1, 3, 4]
# incrementing index, number is either negative or at the right location

# [1, -1, 3, 4]
# => 2
