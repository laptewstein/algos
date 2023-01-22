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

  r.downto(0) do |s_idx|
    c.pred.downto(0) do |p_idx|

      leftmost = s_idx < r && (s[s_idx] == p[p_idx] || p[p_idx] == '.')

      if p[p_idx.succ] == '*'

        # leftmost match is optional if modifier is a '*'
        # /a*b*c/ -> /b*c/ (drop a* lookup)
        cache[s_idx][p_idx] = cache[s_idx][p_idx + 2] || (leftmost && cache[s_idx.succ][p_idx])

      else

        cache[s_idx][p_idx] = leftmost && cache[s_idx.succ][p_idx.succ]

      end
    end
  end
  cache.first.first
end

is_match_dp("abbbc", "a*b*c*")
