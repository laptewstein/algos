# https://leetcode.com/problems/house-robber/

# You are a professional robber planning to rob houses along a street.
# Each house has a certain amount of money stashed,
# the only constraint stopping you from robbing each of them is that
# adjacent houses have security systems connected and it will automatically contact the police
# if two adjacent houses were broken into on the same night.
#
# Given an integer array nums representing the amount of money of each house,
# return the maximum amount of money you can rob tonight without alerting the police.

# Input: nums = [1,2,3,1]
# Output: 4
# Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
# Total amount you can rob = 1 + 3 = 4.
#
# Input: nums = [2,7,9,3,1]
# Output: 12
# Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
# Total amount you can rob = 2 + 9 + 1 = 12.
#
# Input: nums = [2,1,1,2]
# Output: 4
# Explanation: Rob house 1 (money = 2), rob house 4 (money = 4).
# Total amount you can rob = 2 + 2 = 4.


# # recursive, naive
def rob(nums)
  rec = lambda do |idx|
    return 0 if idx < 0
    [ rec[idx - 2] + nums[idx], rec[idx - 1] ].max
  end
  rec[nums.size.pred]
end

require 'benchmark'
Benchmark.bm( 20 ) do |bm|
  bm.report('recursive') { rob([2, 1, 1, 3, 1]) == 5 }
  bm.report { rob([3, 1, 2, 5, 4]) == 9 }
  bm.report { rob([3, 1, 2, 5, 4, 2]) == 10 }
end

# recursive with memoization, still naive
def rob(nums)
  memo = Array.new(nums.size.pred, nil)
  rec = lambda do |idx|
    return 0 if idx < 0
    return memo[idx] if memo[idx]
    memo[idx] = [ rec[idx - 2] + nums[idx], rec[idx - 1] ].max
    memo[idx]
  end
  rec[nums.size.pred]
end

require 'benchmark'
Benchmark.bm( 20 ) do |bm|
  bm.report('recursive with memo') { rob([2, 1, 1, 3, 1]) == 5 }
  bm.report { rob([3, 1, 2, 5, 4]) == 9 }
  bm.report { rob([3, 1, 2, 5, 4, 2]) == 10 }
end

# ------ optimal solutions below
# dynamic programming, one pass, O(n) time *but also* O(n) space
def rob(nums)
  dp = nums[0..0] + Array.new(nums.size.pred, nil)
  (1...nums.size).each do |idx|
    already_stolen = idx > 1 ? dp[idx - 2] : 0
    previous_max   = dp[idx - 1]
    dp[idx]        = [
      already_stolen + nums[idx], # we rob <current> house and add to <already stolen> amount
      previous_max                # we skip this house and use previous house max
    ].max
  end
  dp.last
end

require 'benchmark'
Benchmark.bm( 20 ) do |bm|
  bm.report('dynamic programming') { rob([2, 1, 1, 3, 1]) == 5 }
  bm.report { rob([3, 1, 2, 5, 4]) == 9 }
  bm.report { rob([3, 1, 2, 5, 4, 2]) == 10 }
end

# one pass, O(n) time and O(1) CONSTANT space
def rob(nums)
  current_max = 0
  previous_max  = 0
  nums.each do |current|
    break_in     = [current_max, previous_max + current].max
    previous_max = current_max
    current_max  = break_in
  end
  current_max
end

require 'benchmark'
Benchmark.bm( 20 ) do |bm|
  bm.report('dp constant space') { rob([2, 1, 1, 3, 1]) == 5 }
  bm.report { rob([3, 1, 2, 5, 4]) == 9 }
  bm.report { rob([3, 1, 2, 5, 4, 2]) == 10 }
end

#                          user     system      total        real
# recursive              0.000021   0.000007   0.000028 (  0.000022)
#                        0.000010   0.000004   0.000014 (  0.000013)
#                        0.000012   0.000003   0.000015 (  0.000015)

#                          user     system      total        real
# recursive with memo    0.000013   0.000004   0.000017 (  0.000016)
#                        0.000008   0.000003   0.000011 (  0.000011)
#                        0.000018   0.000000   0.000018 (  0.000014)

#                          user     system      total        real
# dynamic programming    0.000019   0.000000   0.000019 (  0.000018)
#                        0.000010   0.000000   0.000010 (  0.000009)
#                        0.000008   0.000000   0.000008 (  0.000008)

#                          user     system      total        real
# dp constant space      0.000007   0.000002   0.000009 (  0.000008)
#                        0.000005   0.000001   0.000006 (  0.000006)
#                        0.000004   0.000001   0.000005 (  0.000005)