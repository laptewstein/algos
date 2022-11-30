# https://leetcode.com/problems/coin-change/

# You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.

# Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

# You may assume that you have an infinite number of each kind of coin.

def coin_change(coins, amount) # top down approach
  infinity = Float::INFINITY
  cache = [0]

  backtrack = lambda do |target|
    return 0 if target == 0
    return -1 if target < 0
    return cache[target] if cache[target]

    answer = infinity
    for coin in coins
      next if coin > target

      sub_problem = backtrack.call(target - coin)
      answer = sub_problem.succ unless sub_problem == -1
      if answer == infinity
        cache[target] = -1 unless cache[target]
      else
        cache[target] = answer if answer < (cache[target] || infinity)
      end
    end
    cache[target]
  end
  backtrack.call(amount)
  cache[amount] || -1
end

puts coin_change([1, 7, 10], 9)     == 3
puts coin_change([1, 3, 4, 5], 7)   == 2
puts coin_change([3, 4, 5], 2)      == -1
puts coin_change([1, 2, 5, 10], 43) == 6


######
# x2 top down approach. bottom up is the same as perfect squares
def coin_change(coins, amount) 
  cache = [0]

  backtrack = lambda do |target|
    return -1 if target < 0
    return cache[target] if cache[target]

    for coin in coins
      next if coin > target

      sub_problem = backtrack.call(target - coin)
      if sub_problem == -1
        cache[target] = sub_problem unless cache[target]
      else
        sub_problem = sub_problem.succ
        cache[target] =
          if cache[target]
            cache[target] == -1 ? sub_problem : [sub_problem, cache[target]].min
          else
            sub_problem
          end
      end
    end
    cache[target] || -1
  end
  backtrack.call(amount)
  cache[amount] || -1
end

puts coin_change([1, 7, 10], 9)     == 3
puts coin_change([1, 3, 4, 5], 7)   == 2
puts coin_change([3, 4, 5], 2)      == -1
puts coin_change([3, 5, 7], 4)      == -1
puts coin_change([1, 2, 5, 10], 43) == 6

