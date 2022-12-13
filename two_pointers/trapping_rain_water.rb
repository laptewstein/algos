# https://leetcode.com/problems/trapping-rain-water/
# Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water can be trapped after raining.

# Total volume of water trapped is dependent upon the minimum height of two adjacent buildings around current index.

# Take two pointers, left & right side. Update maximums for each on every new height encountered.
# Amount of tyrapped water is governed by: min(maxleft, maxright) - current height

# Time Complexity: O(n), we traverse the array only once. Space Complexity: O(1)
def trapping_rain_water(heights)
  water, left, right  = 0, 0, heights.size.pred
  max_left, max_right = 0, 0

  while left < right
    if heights[left] < heights[right]
      # update left maximum when current reading exceeds previous value
      max_left = heights[left] if heights[left] > max_left

      # max on the left is lesser than max on the right
      # use the lower max - which is the maximum on the LEFT side
      water += max_left - heights[left]

      # advance left pointer
      left = left.succ
    else
      # update right maximum when it exceeds previous value
      max_right = heights[right] if heights[right] > max_right

      # max on the right is lesser than (or equal to) the max on the left
      # use the lower max - which is the maximum on the RIGHT side
      water += max_right - heights[right]
      # advance right pointer
      right = right.pred
    end
  end
  water
end

skyline = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
puts trapping_rain_water(skyline) == 6

