# https://leetcode.com/problems/coin-change/
  
# You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.

# Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

# You may assume that you have an infinite number of each kind of coin.

# top down approach
def coin_change_top_down(coins, amount, cache = [0])
  return amount if amount == 0
  return cache[amount] unless cache[amount].to_i == 0

  coin_count = Float::INFINITY

  for coin in coins
    remainder = amount - coin
    next if remainder < 0

    # returns -1 if amount is lesser than lowest coin
    # if -1, there is no way to make a combination
    # therefore do not set any coin quantity in cache for that target amount
    sub_problem = coin_change_top_down(coins, remainder, cache)
    coin_count = [coin_count, sub_problem.succ].min unless sub_problem < 0
  end
  cache[amount] = coin_count
  coin_count == Float::INFINITY ? -1 : coin_count
end

puts coin_change_top_down([1, 7, 10], 9)     == 3
puts coin_change_top_down([1, 3, 4, 5], 7)   == 2
puts coin_change_top_down([3, 4, 5], 2)      == -1
puts coin_change_top_down([3, 5, 7], 4)      == -1
puts coin_change_top_down([1, 2, 5, 10], 43) == 6

# --------------------------------------------------
# bottom-up technique (prepopulate array with data and work upwards from the lowest amount)
# identical to perfect squares
def coin_change_bottom_up(coins, amount)
  # iitialize cache entries with integer higher than the amount
  # which we are going to use at the end to determine if we replaced this value
  cache = [0] + [amount.succ] * amount
  for target in 1..amount
    for coin in coins
      remainder = target - coin
      next if remainder < 0

      result = cache[remainder].succ
      cache[target] = result if result < cache[target]
    end
  end
  cache[amount] == amount.succ ? -1 : cache[amount]
end

puts coin_change_bottom_up([1, 7, 10], 9)     == 3
puts coin_change_bottom_up([1, 3, 4, 5], 7)   == 2
puts coin_change_bottom_up([3, 4, 5], 2)      == -1
puts coin_change_bottom_up([3, 5, 7], 4)      == -1
puts coin_change_bottom_up([1, 2, 5, 10], 43) == 6

