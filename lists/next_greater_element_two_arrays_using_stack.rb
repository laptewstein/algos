# https://leetcode.com/problems/next-greater-element-i
# Time:  O(m + n)
# Space: O(m + n)

# You are given two arrays (without duplicates) nums1 and nums2 where nums1’s elements are subset of nums2.
# Find all the next greater numbers for nums1's elements in the corresponding places of nums2.
#
# The Next Greater Number of a number x in nums1 is the first greater number to its right in nums2.
# If it does not exist, output -1 for this number.
#
# Example 1:
# Input: nums1 = [4,1,2], nums2 = [1,3,4,2].
# Output: [-1,3,-1]
# Explanation:
#     For number 4 in the first array, you cannot find the next greater number for it in the second array, so output -1.
#     For number 1 in the first array, the next greater number for it in the second array is 3.
#     For number 2 in the first array, there is no next greater number for it in the second array, so output -1.
# Example 2:
# Input: nums1 = [2,4], nums2 = [1,2,3,4].
# Output: [3,-1]
# Explanation:
#     For number 2 in the first array, the next greater number for it in the second array is 3.
#     For number 4 in the first array, there is no next greater number for it in the second array, so output -1.
# Note:
# All elements in nums1 and nums2 are unique.
# The length of both nums1 and nums2 would not exceed 1000.

def next_greater_element(nums1, nums2)
  stack = []
  hash = {}
  # go backwards from end of the array
  nums2.count.pred.step(0, -1).each do |idx|
    num = nums2[idx]
    unless stack.empty?
      # iterate over stack elements backwards from the most recently added item to the oldest
      # detect if we have seen an element higher than current.
      # keep it on the stack.
      greater_element_idx = stack.count.pred.step(0, -1).detect { |i| stack[i] > num }
      hash[num] = stack[greater_element_idx] if greater_element_idx
    end
    stack << num
  end
  nums1.map { |num| hash[num] || -1 }
end

puts next_greater_element([4, 1, 2], [1, 3, 4, 2]) == [-1, 3, -1]
puts next_greater_element([2, 4], [1, 2, 3, 4]) == [3, -1]
puts next_greater_element([1, 3, 5, 2, 4], [6, 5, 4, 3, 2, 1, 7]) == [7, 7, 7, 7, 7]
