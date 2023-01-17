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
#
# 0. Initialize the last element of the dp array to 1 (which is OOB at <last index + 1>)
# 1. Iterate through the string backwards.
# 2. For each character:
#   - if character is == "0":
#       It cannot be used as a single digit in any decoding,
#       set the dp[index] to 0 and continue to next.

#   - If char != 0:
#       a) set the dp value to the number of ways
#       that the substring starting at <next index> can be decoded,
#       and
#       b) add the number of ways that the substring starting from the
#       next two characters can be decoded, given that
#       the next of two characters comibined are less than 27 in value
#       (a valid <two digit letter> which can be read either way).
# 3. Return the first element of the dp array, which represents
# the number of ways that the entire input string can be decoded.
def num_decodings_dp(s)
  dp = []
  dp[s.length] = 1
  (s.length.pred).downto(0).each do |idx|
    next dp[idx] = 0 if s[idx] == "0"

    dp[idx] = dp[idx.succ]
    next if idx == s.length.pred # only one way to decode a singe char / digit

    # We're at - or - before the second last character.
    # [WE ARE STILL AT THE SAME NUMBER OF WAYS OF DECODING THE STRING AT THIS POINT]
    # - one single additional digit on its own does not add any new scope.

    # unless a combination of two chars at <current index + one char after>
    # is a valid letter too. If so: we've found YET ANOTHER WAY to decode the sequence
    # as <two independent single digit chars> AND <an additional char, two-digits long>
    dp[idx] += dp[idx + 2] if s[idx, 2].to_i < 27 # == s[idx..idx.succ]
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
