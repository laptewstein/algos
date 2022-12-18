# https://leetcode.com/problems/burst-balloons/
# You are given n balloons, indexed from 0 to n - 1. Each balloon is painted with a number on it represented by an array nums. You are asked to burst all the balloons.

# If you burst the ith balloon, you will get nums[i - 1] * nums[i] * nums[i + 1] coins. If i - 1 or i + 1 goes out of bounds of the array, then treat it as if there is a balloon with a 1 painted on it.

# Return the maximum coins you can collect by bursting the balloons wisely.

# args       = [3, 1, 5, 8]
# posiitions =  0  1  2  3

# function(0, 3) = max(
#   0              + 1 * 3 * 1 + function(1, 3),    # calculation for whole array
#   function(0, 0) + 1 * 1 * 1 + function(2, 3),
#   function(0, 1) + 1 * 5 * 1 + function(3, 3),
#   function(0, 2) + 1 * 8 * 1 + 0,
# )

# function(1, 3) = max(
#   0              + (1 * 1 * 1) + function(2, 3),  # subarray: 1 is the last to burst
#   function(1, 1) + (1 * 5 * 1) + function(3, 3),  # subarray: 5 is the last to burst
#   function(1, 2) + (1 * 8 * 1) + 0,               # subarray: 8 is the last to burst
# )

# formula:
# for last_to_burst in i..j
#   max of  (
#     dp[i][last_to_burst - 1]
#       + num[i - 1] * num[last_to_burst] * num[j + 1]
#       + dp[last_to_burst + 1][j]
#   )

def maxCoins(nums)
  array_size = nums.size
  return 0 unless array_size > 0

  dp = Array.new(array_size) { Array.new(array_size, 0) }
  # [
  #   [ 0, 0, 0, 0 ],
  #   [ 0, 0, 0, 0 ],
  #   [ 0, 0, 0, 0 ],
  #   [ 0, 0, 0, 0 ],
  # ]

  (0...array_size).each do |subarray_length|
    (0...array_size).each do |lsb_idx|              # left_subarray_boundary
      puts "--- left_subarray_boundary: #{lsb_idx}, subarray_length: #{subarray_length}"
      rsb_idx = lsb_idx + subarray_length           # right_subarray_boundary
      break if rsb_idx == array_size                # stop if right boundary is Out-of-Bound

      puts "--- right_subarray_boundary: #{rsb_idx}"

      (lsb_idx..rsb_idx).each do |idx|              # index inside subarray
        central_baloon = nums[idx]
        puts "--- baloon idx: #{idx}, central_baloon: #{central_baloon} (from #{nums.inspect})"

        # side baloons
        # if central_baloon is first, left side multiplicand should be 1
        left_baloon  = lsb_idx == 0               ? 1 : nums[lsb_idx.pred]
        # if central_baloon is last, right side multiplicand would be 1
        right_baloon = rsb_idx == array_size.pred ? 1 : nums[rsb_idx.succ]

        puts "+++ left_baloon: #{left_baloon}, central_baloon: #{central_baloon}, right_baloon: #{right_baloon}"

        left = idx == lsb_idx ? 0 : dp[lsb_idx][idx.pred]
        right = idx == rsb_idx ? 0 : dp[idx.succ][rsb_idx]

        baloon_burst = left_baloon * central_baloon * right_baloon
        payout = left + baloon_burst + right

        puts "$$$ left: #{left}, balloon_burst: #{baloon_burst}, right: #{right}, payout: #{payout}"

        cached_value = dp[lsb_idx][rsb_idx]

        puts "~~~~ cached_value: #{cached_value} at row #{lsb_idx}, col #{rsb_idx}"
        puts ">>>> Before: " + dp.inspect
        dp[lsb_idx][rsb_idx] = payout if payout > dp[lsb_idx][rsb_idx]
        puts "<<<< After : " + dp.inspect + "\n "
      end
    end
  end
  puts dp.inspect
  dp.first.last
end

# christmas_baloons = [5, 2, 4, 9]
# puts maxCoins(christmas_baloons) == 274

birthday_baloons = [3, 1, 5, 8]
puts maxCoins(birthday_baloons) == 167
# [[3, 30, 159, 167], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
# => true

# --- left_subarray_boundary: 0, subarray_length: 0
# --- right_subarray_boundary: 0
# --- baloon idx: 0, central_baloon: 3 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 3, right_baloon: 1
# $$$ left: 0, balloon_burst: 3, right: 0, payout: 3
# ~~~~ cached_value: 0 at row 0, col 0
# >>>> Before: [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
# <<<< After : [[3, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
 
# --- left_subarray_boundary: 1, subarray_length: 0
# --- right_subarray_boundary: 1
# --- baloon idx: 1, central_baloon: 1 (from [3, 1, 5, 8])
# +++ left_baloon: 3, central_baloon: 1, right_baloon: 5
# $$$ left: 0, balloon_burst: 15, right: 0, payout: 15
# ~~~~ cached_value: 0 at row 1, col 1
# >>>> Before: [[3, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
# <<<< After : [[3, 0, 0, 0], [0, 15, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
 
# --- left_subarray_boundary: 2, subarray_length: 0
# --- right_subarray_boundary: 2
# --- baloon idx: 2, central_baloon: 5 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 5, right_baloon: 8
# $$$ left: 0, balloon_burst: 40, right: 0, payout: 40
# ~~~~ cached_value: 0 at row 2, col 2
# >>>> Before: [[3, 0, 0, 0], [0, 15, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
# <<<< After : [[3, 0, 0, 0], [0, 15, 0, 0], [0, 0, 40, 0], [0, 0, 0, 0]]
 
# --- left_subarray_boundary: 3, subarray_length: 0
# --- right_subarray_boundary: 3
# --- baloon idx: 3, central_baloon: 8 (from [3, 1, 5, 8])
# +++ left_baloon: 5, central_baloon: 8, right_baloon: 1
# $$$ left: 0, balloon_burst: 40, right: 0, payout: 40
# ~~~~ cached_value: 0 at row 3, col 3
# >>>> Before: [[3, 0, 0, 0], [0, 15, 0, 0], [0, 0, 40, 0], [0, 0, 0, 0]]
# <<<< After : [[3, 0, 0, 0], [0, 15, 0, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
 
# --- left_subarray_boundary: 0, subarray_length: 1
# --- right_subarray_boundary: 1
# --- baloon idx: 0, central_baloon: 3 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 3, right_baloon: 5
# $$$ left: 0, balloon_burst: 15, right: 15, payout: 30
# ~~~~ cached_value: 0 at row 0, col 1
# >>>> Before: [[3, 0, 0, 0], [0, 15, 0, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 0, 0], [0, 15, 0, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
 
# --- baloon idx: 1, central_baloon: 1 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 1, right_baloon: 5
# $$$ left: 3, balloon_burst: 5, right: 0, payout: 8
# ~~~~ cached_value: 30 at row 0, col 1
# >>>> Before: [[3, 30, 0, 0], [0, 15, 0, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 0, 0], [0, 15, 0, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
 
# --- left_subarray_boundary: 1, subarray_length: 1
# --- right_subarray_boundary: 2
# --- baloon idx: 1, central_baloon: 1 (from [3, 1, 5, 8])
# +++ left_baloon: 3, central_baloon: 1, right_baloon: 8
# $$$ left: 0, balloon_burst: 24, right: 40, payout: 64
# ~~~~ cached_value: 0 at row 1, col 2
# >>>> Before: [[3, 30, 0, 0], [0, 15, 0, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 0, 0], [0, 15, 64, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
 
# --- baloon idx: 2, central_baloon: 5 (from [3, 1, 5, 8])
# +++ left_baloon: 3, central_baloon: 5, right_baloon: 8
# $$$ left: 15, balloon_burst: 120, right: 0, payout: 135
# ~~~~ cached_value: 64 at row 1, col 2
# >>>> Before: [[3, 30, 0, 0], [0, 15, 64, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 0, 0], [0, 15, 135, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
 
# --- left_subarray_boundary: 2, subarray_length: 1
# --- right_subarray_boundary: 3
# --- baloon idx: 2, central_baloon: 5 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 5, right_baloon: 1
# $$$ left: 0, balloon_burst: 5, right: 40, payout: 45
# ~~~~ cached_value: 0 at row 2, col 3
# >>>> Before: [[3, 30, 0, 0], [0, 15, 135, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 0, 0], [0, 15, 135, 0], [0, 0, 40, 45], [0, 0, 0, 40]]
 
# --- baloon idx: 3, central_baloon: 8 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 8, right_baloon: 1
# $$$ left: 40, balloon_burst: 8, right: 0, payout: 48
# ~~~~ cached_value: 45 at row 2, col 3
# >>>> Before: [[3, 30, 0, 0], [0, 15, 135, 0], [0, 0, 40, 45], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 0, 0], [0, 15, 135, 0], [0, 0, 40, 48], [0, 0, 0, 40]]
 
# --- left_subarray_boundary: 3, subarray_length: 1
# --- left_subarray_boundary: 0, subarray_length: 2
# --- right_subarray_boundary: 2
# --- baloon idx: 0, central_baloon: 3 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 3, right_baloon: 8
# $$$ left: 0, balloon_burst: 24, right: 135, payout: 159
# ~~~~ cached_value: 0 at row 0, col 2
# >>>> Before: [[3, 30, 0, 0], [0, 15, 135, 0], [0, 0, 40, 48], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 159, 0], [0, 15, 135, 0], [0, 0, 40, 48], [0, 0, 0, 40]]
 
# --- baloon idx: 1, central_baloon: 1 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 1, right_baloon: 8
# $$$ left: 3, balloon_burst: 8, right: 40, payout: 51
# ~~~~ cached_value: 159 at row 0, col 2
# >>>> Before: [[3, 30, 159, 0], [0, 15, 135, 0], [0, 0, 40, 48], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 159, 0], [0, 15, 135, 0], [0, 0, 40, 48], [0, 0, 0, 40]]
 
# --- baloon idx: 2, central_baloon: 5 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 5, right_baloon: 8
# $$$ left: 30, balloon_burst: 40, right: 0, payout: 70
# ~~~~ cached_value: 159 at row 0, col 2
# >>>> Before: [[3, 30, 159, 0], [0, 15, 135, 0], [0, 0, 40, 48], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 159, 0], [0, 15, 135, 0], [0, 0, 40, 48], [0, 0, 0, 40]]
 
# --- left_subarray_boundary: 1, subarray_length: 2
# --- right_subarray_boundary: 3
# --- baloon idx: 1, central_baloon: 1 (from [3, 1, 5, 8])
# +++ left_baloon: 3, central_baloon: 1, right_baloon: 1
# $$$ left: 0, balloon_burst: 3, right: 48, payout: 51
# ~~~~ cached_value: 0 at row 1, col 3
# >>>> Before: [[3, 30, 159, 0], [0, 15, 135, 0], [0, 0, 40, 48], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 159, 0], [0, 15, 135, 51], [0, 0, 40, 48], [0, 0, 0, 40]]
 
# --- baloon idx: 2, central_baloon: 5 (from [3, 1, 5, 8])
# +++ left_baloon: 3, central_baloon: 5, right_baloon: 1
# $$$ left: 15, balloon_burst: 15, right: 40, payout: 70
# ~~~~ cached_value: 51 at row 1, col 3
# >>>> Before: [[3, 30, 159, 0], [0, 15, 135, 51], [0, 0, 40, 48], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 159, 0], [0, 15, 135, 70], [0, 0, 40, 48], [0, 0, 0, 40]]
 
# --- baloon idx: 3, central_baloon: 8 (from [3, 1, 5, 8])
# +++ left_baloon: 3, central_baloon: 8, right_baloon: 1
# $$$ left: 135, balloon_burst: 24, right: 0, payout: 159
# ~~~~ cached_value: 70 at row 1, col 3
# >>>> Before: [[3, 30, 159, 0], [0, 15, 135, 70], [0, 0, 40, 48], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 159, 0], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
 
# --- left_subarray_boundary: 2, subarray_length: 2
# --- left_subarray_boundary: 0, subarray_length: 3
# --- right_subarray_boundary: 3
# --- baloon idx: 0, central_baloon: 3 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 3, right_baloon: 1
# $$$ left: 0, balloon_burst: 3, right: 159, payout: 162
# ~~~~ cached_value: 0 at row 0, col 3
# >>>> Before: [[3, 30, 159, 0], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 159, 162], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
 
# --- baloon idx: 1, central_baloon: 1 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 1, right_baloon: 1
# $$$ left: 3, balloon_burst: 1, right: 48, payout: 52
# ~~~~ cached_value: 162 at row 0, col 3
# >>>> Before: [[3, 30, 159, 162], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 159, 162], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
 
# --- baloon idx: 2, central_baloon: 5 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 5, right_baloon: 1
# $$$ left: 30, balloon_burst: 5, right: 40, payout: 75
# ~~~~ cached_value: 162 at row 0, col 3
# >>>> Before: [[3, 30, 159, 162], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 159, 162], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
 
# --- baloon idx: 3, central_baloon: 8 (from [3, 1, 5, 8])
# +++ left_baloon: 1, central_baloon: 8, right_baloon: 1
# $$$ left: 159, balloon_burst: 8, right: 0, payout: 167
# ~~~~ cached_value: 162 at row 0, col 3
# >>>> Before: [[3, 30, 159, 162], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
# <<<< After : [[3, 30, 159, 167], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
 
# --- left_subarray_boundary: 1, subarray_length: 3
# [[3, 30, 159, 167], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
# true
