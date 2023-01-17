# https://leetcode.com/problems/decode-ways/

# Given a string containing only digits, return the number of ways to decode it.

# A message containing letters from A-Z can be encoded into numbers using the following mapping:
# 'A' -> "1"
# 'B' -> "2"
# ...
# 'Z' -> "26"

# To decode an encoded message, all the digits must be grouped then mapped back
# into letters using the reverse of the mapping above (there may be multiple ways).
#
# For example, "11106" can be mapped into:
#   "AAJF" with the grouping (1 1 10 6)
#   "KJF" with the grouping (11 10 6)
#
# Note that the grouping (1 11 06) is invalid because "06" cannot be mapped into 'F',
# since "6" is different from "06".

tests = {
  "12"    => ["AB", "L"],
  "11106" => ["AAJF", "KJF"],
  "226"   => ["BZ", "VF", "BBF"],
  "06"    => []
}

# backtracking, returns *matches*
def decodings_with_matches(s)
  mapping   = Hash[('A'..'Z').map { |char| ["#{char.ord - 64}", char] }]
  resultset = []
  decode = lambda do |l, res|
    return resultset << res if l == s.length

    r = [l.succ, s.length.pred].min
    (l..r).each do |right_boundary|
      next if s[l] == '0'       # mapping starts with 1 for 'A'

      code = s[l..right_boundary]
      next unless mapping[code] # no char exceeds 26

      decode[right_boundary.succ, res + mapping[code]]
    end
  end
  decode[0, '']
  resultset
end

# tests
tests.map do |concatenated, decoded|
  results = decodings_with_matches(concatenated)
  puts [results.sort == decoded.sort, concatenated + ": #{results}"]
end


# backtracking, returns match *count*
def num_decodings(s)
  mapping = Hash[('A'..'Z').map { |char| ["#{char.ord - 64}", char] }]
  count   = 0

  decode = lambda do |l, res|
    count += 1 and return if l == s.length # processed entre string

    r = [l.succ, s.length.pred].min
    (l..r).each do |right_boundary|
      next if s[l] == '0' # mapping starts with 1 for 'A'

      code = s[l..right_boundary]
      next unless mapping[code] # no char exceeds 26

      decode[right_boundary.succ, res + mapping[code]]
    end
  end
  decode[0, '']
  count
end


# tests
tests.map do |concatenated, decoded|
  results = num_decodings(concatenated)
  puts results == decoded.count
end


# DP
# A classic DP problem
# There are no ways to decode a string which starts with 0.
def num_decodings_dp(s)
  dp = []
  dp[s.length] = 1
  (s.length.pred).downto(0).each do |idx|
    if s[idx] == "0"
      dp[idx] = 0
    else
      dp[idx] = dp[idx.succ]
      if idx < s.length.pred
        dp[idx] += dp[idx + 2] if s[idx, 2].to_i < 27
      end
    end
  end
  # puts dp.inspect
  dp.first
end

tests.map do |concatenated, decoded|
  results = num_decodings_dp(concatenated)
  puts results == decoded.count
end

# [2, 1, 1]             # "12"    => ["AB", "L"]
# [2, 1, 1, 0, 1, 1]    # "11106" => ["AAJF", "KJF"],
# [3, 2, 1, 1]          # "226"   => ["BZ", "VF", "BBF"],
# [0, 1, 1]             # "06"    => []
