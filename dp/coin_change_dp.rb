# Coin Change
# Let’s see another classic, the infamous “Coin Change” problem. 
# There’re two variation of this problem, the first one: You are given coins of different denominations and a total amount of money amount. 

# Write a function to compute the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1. 

# For example given coins [1, 2, 5] and the total amount 11, the result is 3 because 11 = 5 + 5 + 1. 
# And you may assume that you have an infinite number of each kind of coin. 

# Let’s break it down:

# dp[i]: the fewest number of coins that makes up amount i.
# For amount i, we can choose which kind of coin we use, for certain coin x, we get dp[i] = dp[i-x] + 1, and we do this for all kinds of coins: dp[i] = min(dp[i-{for x in coins if x <= i}] + 1).
# dp table is initialized with INFINITY which makes comparision easier.
# dp[0] is 0, because we need 0 coins to making up amount 0.

def change(coins, amount)
  dp = Array.new(amount.succ, Float::INFINITY)
  (0..amount).each do |sum|
    coins.each do |coin|
      dp[sum] = [ dp[sum], dp[sum - coin].succ ].min unless coin > sum
    end
  end
  dp[amount] == Float::INFINITY ? -1 : dp[amount]
end


# The second variation of the coin change problem: given coins of different denominations and a total amount of money. 
Write a function to COMPUTE THE NUMBER OF COMBINATIONS that make up that amount. 
You may assume that you have infinite number of each kind of coin. 

# Unlike the first one, we have to decide whether to use certain coin or not, so a one dimensional DP table won’t suffice. 

# To simplify this problem for my brain, I see this problem as Integer partition. Integer partition is number of ways a number can be represented as sum of positive integers. e.g. 4 => 4 / 3+1 / 2+2 / 2+1+1 / 1+1+1+1, so there are 4 ways, also 3+1 and 1+3 are considered as only one. you can imagine a big table of size N*N where N is size of all natural number, e.g. table[4][4] = 4, so it contains all the solutions for any combination of coins and given amount. Now instead of all natural number, you’re given only some certain integers, aka coins.

# For coins: [2,3,5], amount: 7, we have this table

#   *	0	1	2	3	4	5	6	7
#   0	1	0	0	0	0	0	0	0
#   2	1	0	1	0	1	0	1	0
#   3	1	0	1	1	1	1	2	1
#   5	1	0	1	1	1	2	2	2

# dp[i][j]: number of ways that make up amount j using first i coins.
# the first row should all be zero except for the dp[0][0].
# dp[0][0] is 1. It’s weird I know, but when you think about it, dp[x][x] should never be zero.
# To determine dp[i][j] we have two choices:
# Use current coin: dp[i][j-x] where x is the current coin denomination.
# Don’t use current coin: dp[i-1][j], just ignore current coin.
# dp[i][j] is the sum of these two choices.

def change(coins, amount)
  cache = Array.new(coins.size.succ) { Array.new(amount.succ, 0) }
  cache[0][0] = 1
  (1..coins.size).each do |coin|
    (0..amount).each do |sum|
      if sum < coins[coin.pred]
        previous_count = 0
      else
        previous_count = cache[coin][sum - coins[coin.pred]]
      cache[coin][sum] = previous_count + cache[coin.pred][sum]
    end
  end
  dp.last.last
end