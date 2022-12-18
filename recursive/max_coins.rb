def maxCoins(nums)
  count = nums.size
  return 0 unless count > 0

  dp = Array.new(count) { Array.new(count, 0) }
  # [
  #   [[], [], [], []],
  #   [[], [], [], []],
  #   [[], [], [], []],
  #   [[], [], [], []]
  # ]
  (0...count).each do |n|
    (0...count).each do |i|
      j = n + i
      break unless j < count

      (i..j).each do |idx|
        left_num  = i == 0          ? 1 : nums[i.pred]
        right_num = j == count.pred ? 1 : nums[j.succ]

        left = idx == i ? 0 : dp[i][idx.pred]
        right = idx == j ? 0 : dp[idx.succ][j]
        puts "\n---- " + dp.inspect
        payout = left_num * nums[idx] * right_num + left + right
        puts "n: #{n}, i: #{i}, j: #{j}, idx: #{idx}, nums[idx]: #{nums[idx]}, left_num: #{left_num}, right_num: #{right_num}, left: #{left}, right: #{right}, payout: #{payout}"

        dp[i][j] = payout if payout > dp[i][j]
      end
    end
  end
  puts dp.inspect
  dp[0][count.pred]
end

birthday_baloons = [3, 1, 5, 8]
# christmas_baloons = [5, 2, 4, 9]

puts maxCoins(birthday_baloons) == 167
# puts maxCoins(christmas_baloons) == 274

# ---- [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
# n: 0, i: 0, j: 0, idx: 0, nums[idx]: 3, left_num: 1, right_num: 1, left: 0, right: 0, payout: 3

# ---- [[3, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
# n: 0, i: 1, j: 1, idx: 1, nums[idx]: 1, left_num: 3, right_num: 5, left: 0, right: 0, payout: 15

# ---- [[3, 0, 0, 0], [0, 15, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
# n: 0, i: 2, j: 2, idx: 2, nums[idx]: 5, left_num: 1, right_num: 8, left: 0, right: 0, payout: 40

# ---- [[3, 0, 0, 0], [0, 15, 0, 0], [0, 0, 40, 0], [0, 0, 0, 0]]
# n: 0, i: 3, j: 3, idx: 3, nums[idx]: 8, left_num: 5, right_num: 1, left: 0, right: 0, payout: 40

# ---- [[3, 0, 0, 0], [0, 15, 0, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
# n: 1, i: 0, j: 1, idx: 0, nums[idx]: 3, left_num: 1, right_num: 5, left: 0, right: 15, payout: 30

# ---- [[3, 30, 0, 0], [0, 15, 0, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
# n: 1, i: 0, j: 1, idx: 1, nums[idx]: 1, left_num: 1, right_num: 5, left: 3, right: 0, payout: 8

# ---- [[3, 30, 0, 0], [0, 15, 0, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
# n: 1, i: 1, j: 2, idx: 1, nums[idx]: 1, left_num: 3, right_num: 8, left: 0, right: 40, payout: 64

# ---- [[3, 30, 0, 0], [0, 15, 64, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
# n: 1, i: 1, j: 2, idx: 2, nums[idx]: 5, left_num: 3, right_num: 8, left: 15, right: 0, payout: 135

# ---- [[3, 30, 0, 0], [0, 15, 135, 0], [0, 0, 40, 0], [0, 0, 0, 40]]
# n: 1, i: 2, j: 3, idx: 2, nums[idx]: 5, left_num: 1, right_num: 1, left: 0, right: 40, payout: 45

# ---- [[3, 30, 0, 0], [0, 15, 135, 0], [0, 0, 40, 45], [0, 0, 0, 40]]
# n: 1, i: 2, j: 3, idx: 3, nums[idx]: 8, left_num: 1, right_num: 1, left: 40, right: 0, payout: 48

# ---- [[3, 30, 0, 0], [0, 15, 135, 0], [0, 0, 40, 48], [0, 0, 0, 40]]
# n: 2, i: 0, j: 2, idx: 0, nums[idx]: 3, left_num: 1, right_num: 8, left: 0, right: 135, payout: 159

# ---- [[3, 30, 159, 0], [0, 15, 135, 0], [0, 0, 40, 48], [0, 0, 0, 40]]
# n: 2, i: 0, j: 2, idx: 1, nums[idx]: 1, left_num: 1, right_num: 8, left: 3, right: 40, payout: 51

# ---- [[3, 30, 159, 0], [0, 15, 135, 0], [0, 0, 40, 48], [0, 0, 0, 40]]
# n: 2, i: 0, j: 2, idx: 2, nums[idx]: 5, left_num: 1, right_num: 8, left: 30, right: 0, payout: 70

# ---- [[3, 30, 159, 0], [0, 15, 135, 0], [0, 0, 40, 48], [0, 0, 0, 40]]
# n: 2, i: 1, j: 3, idx: 1, nums[idx]: 1, left_num: 3, right_num: 1, left: 0, right: 48, payout: 51

# ---- [[3, 30, 159, 0], [0, 15, 135, 51], [0, 0, 40, 48], [0, 0, 0, 40]]
# n: 2, i: 1, j: 3, idx: 2, nums[idx]: 5, left_num: 3, right_num: 1, left: 15, right: 40, payout: 70

# ---- [[3, 30, 159, 0], [0, 15, 135, 70], [0, 0, 40, 48], [0, 0, 0, 40]]
# n: 2, i: 1, j: 3, idx: 3, nums[idx]: 8, left_num: 3, right_num: 1, left: 135, right: 0, payout: 159

# ---- [[3, 30, 159, 0], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
# n: 3, i: 0, j: 3, idx: 0, nums[idx]: 3, left_num: 1, right_num: 1, left: 0, right: 159, payout: 162

# ---- [[3, 30, 159, 162], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
# n: 3, i: 0, j: 3, idx: 1, nums[idx]: 1, left_num: 1, right_num: 1, left: 3, right: 48, payout: 52

# ---- [[3, 30, 159, 162], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
# n: 3, i: 0, j: 3, idx: 2, nums[idx]: 5, left_num: 1, right_num: 1, left: 30, right: 40, payout: 75

# ---- [[3, 30, 159, 162], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
# n: 3, i: 0, j: 3, idx: 3, nums[idx]: 8, left_num: 1, right_num: 1, left: 159, right: 0, payout: 167
# [[3, 30, 159, 167], [0, 15, 135, 159], [0, 0, 40, 48], [0, 0, 0, 40]]
# true

