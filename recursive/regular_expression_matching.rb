# https://leetcode.com/problems/regular-expression-matching/

# Regular Expression Matching

# Given an input string s and a pattern p,
# implement regular expression matching with support for '.' and '*' where:
#
#  - '.' Matches <any> single character.​​​​
#  - '*' Matches <zero or more> of the preceding element.

#  - ".*" means <zero or more of any character>
#  - OUT OF SCOPE: '+' - Matches <one or more> of the preceding element.

# The matching should cover the entire input string (not partial).

# Recursion: top-down (start-to-end)
def is_match_naive(s, p)
  # base case
  return s.empty? if p.empty?

  # leftmost match is optional if modifier is a '*'
  # /a*b*c/ -> /b*c/ (drop a* lookup)
  return true if p[1] == '*' && is_match(s, p[2..-1])

  # leftmost char must match
  return false unless s[0] == p[0] || p[0] == '.'

  # [a]abbc -> abbc (see if next char matches too, stay with same pattern)
  return is_match(s[1..-1], p) if p[1] == '*'

  # there was a match at [idx] but pattern's next is NOT a modifier
  # advance both to the next char
  is_match(s[1..-1], p[1..-1])
end

# optimize without string splitting (use indexes)
def is_match(s, p, s_idx = 0, p_idx = 0)
  # base case
  return s_idx == s.length if p_idx == p.length

  # leftmost match is optional if modifier is a '*'
  # /a*b*c/ -> /b*c/ (drop a* lookup)
  return true if p[p_idx.succ] == '*' && is_match(s, p, s_idx, p_idx + 2)

  # leftmost char must match
  return false unless s[s_idx] == p[p_idx] || p[p_idx] == '.'

  if p[p_idx.succ] == '*'
    # [a]abbc -> abbc (see if next char matches too, stay with same pattern)
    is_match(s, p, s_idx.succ, p_idx)
  else
    # there was a match at [idx] but pattern's next is NOT a modifier
    # advance both to the next char
    is_match(s, p, s_idx.succ, p_idx.succ)
  end
end

# DP: bottom-up (end-to-start)
# DP is just an iterative version of the recursive approach with the benefit of memoization.
def is_match_dp(s, p)
  r, c = s.length, p.length

  # table with all values set to false; (one extra row and column)
  cache       = Array.new(r.succ) { Array.new(c.succ, false) }
  cache[r][c] = true # empty string + empty pattern = match

  # iterate from the end
  r.downto(0) do |s_idx|        # string
    c.pred.downto(0) do |p_idx| # pattern

      # if <next> is a '*' modifier: match of <current character> is optional
      # rest of string defines the outcome; /a*b*c/ -> /b*c/ (drop a* lookup)
      next cache[s_idx][p_idx] = true if p[p_idx.succ] == '*' && cache[s_idx][p_idx + 2]

      # edge case: string index is OOB
      next cache[s_idx][p_idx] = false unless s_idx < r

      # current character must match
      next cache[s_idx][p_idx] = false unless s[s_idx] == p[p_idx] || p[p_idx] == '.'

      # a) if next <pattern char> is a modifier:
      #       with the same pattern, rely on the cached next char result
      #       i.e [a]abbc -> abbc
      # b) rely on cached result (result for both pointers shifted)
      #       i.e. [b]bc -> [b]c
      match_is_optional = p[p_idx.succ] == '*' # none or more
      cache[s_idx][p_idx] = cache[s_idx.succ][match_is_optional ? p_idx : p_idx.succ]
    end
  end
  cache.first.first
end

puts is_match_dp("abbbsc", "a*b*.*c*")
