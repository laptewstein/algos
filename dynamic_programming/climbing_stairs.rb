# https://leetcode.com/problems/climbing-stairs/description/

# You are climbing a staircase. It takes n steps to reach the top.
# Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
#
# Input: n = 2
# Output: 2
# Explanation: There are TWO ways to climb to the top.
# 1. 1 step + 1 step
# 2. 2 steps

# Input: n = 3
# Output: 3
# Explanation: There are THREE ways to climb to the top.
# 1. 1 step + 1 step + 1 step
# 2. 1 step + 2 steps
# 3. 2 steps + 1 step


def climb_stairs(n)
  cache = { 1 => 1, 2 => 2 }
  rec = lambda do |val|
    memoized = cache[val]
    return memoized if memoized
    cache[val.pred]       = rec[val.pred]
    cache[val.pred.pred] = rec[val.pred.pred]
    cache[val.pred] + cache[val.pred.pred]
  end
  rec[n]
end

puts climb_stairs(7) == 21
puts climb_stairs(15) == 987

# # no memoization (ineffective over large n)
# def climb_stairs(n)
#   dp = { 1 => 1, 2 => 2 }
#   rec = lambda do |val|
#     return dp[val] if dp[val]
#     rec[val.pred] + rec[val.pred.pred]
#   end
#   rec[n]
# end

# 10x using lang constructs
def climb_stairs(n)
  Hash.new { |h, k| h[k] = h[k-1] + h[k-2] }.merge({1=>1, 2=>2})[n]
end

# 10x using cache and n space (array)
def climb_stairs(n)
  cache = (0...3).to_a
  return cache[n] if n < 3
  (3..n).each do |val|
    cache[val] = cache[val.pred] + cache[val.pred.pred]
  end
  cache[n]
end
