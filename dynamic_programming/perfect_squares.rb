# https://leetcode.com/problems/perfect-squares/description/
# Given an integer n, return the least number of perfect square numbers that sum to n.

# ------
# A perfect square is an integer that is the square of an integer.
# In other words, it is the product of some integer with itself.
# For example, 1, 4, 9, and 16 are perfect squares while 3 and 11 are not.
# ------

# Its a "bottom up approach",
# which means that before giving an answer of how many squares are there within n, we are going to have to figure out
# how many squares are in all the numbers lesser than n,
# all the way to 0 (and if n == 0, its 0 squares)

# for n = 12, array below contains all the number of squares from n = 0 to n = 12
# [ 0, 1, 2, 3, 1, 2, 3, 4, 2, 1, 2, 3, 3 ]

# i.e for n = 6, its 2 ^ 2 (1) + (1^2)+ (1^2) => 3
# i.e for n = 7, its 2 ^ 2 (1) + (1^2) + (1^2) + (1^2) => 4
# and for n = 9, its 3 ^ 3 (1) => 1

def num_squares(n)
  # ranging from 1 to N, initially populate cache of squares naively with 1^2 * n times; index matches values
  # Note: index 0 => made of 0 perfect squares, instrumental to perfect squares with no remainder left (more below).
  # Initially looks like this: [0, 1, 2, ..., n.pred, n]
  dp_cache = (0..n).to_a

  # optimize and compute perfect squares solutions for numbers between 1 and N
  for target in 1..n

    # detrermine how many <square of a number> from 1^2 up to <target> can "fit" into <target>
    for int in 1..target
      square = int * int

      # if <square of number> is higher than <target>: current integer is too high.
      # Example: <target> = 12, <int> = 4 (and <square> = 4^2); then 16 > 12
      # break out of internal loop iteration for current <target>
      break if square > target

      remainder = target - square
      # if <square> is equal to <target>, its still, one (1) perfect square
      # always use previosuly calculated value for the <remainder> plus current square count (which is always 1)
      perfect_square_count = dp_cache[remainder].succ

      # compare cached count (n * 1^2) with the <perfect_square_count>
      # Example A:
      #   target = 12, int = 2, square = 4, remainder = (12 - 2*2) = 8;
      #   cached <target> 8 is equal to 2 perfect squares made of 2^2 + 2^2.
      #   This makes target 12 to be 2 + (1) => 3 perfect squares.
      # Example B:
      #   same target = 12, int = 3, square = 9, remaider = (12 - 3*3) = 3;
      #   cached <target> 3 is equal to 3 perfect squares of 1^2.
      #   This makes target 12 to be 3 + (1) => 4 perfect squares which is higher than example A above.
      #   Previous iteration of <int> (when <int> was 2) had lower square count. Skip updating.
      # Example C:
      #   target = 16, int = 4, square = 16, remainder = 0;
      #   cached <remainder target> 0 is made of 0 perfect squares.
      #   This makes target 16 to be 0 + (1) => 1 perfect square which is optimal.
      dp_cache[target] = perfect_square_count if perfect_square_count < dp_cache[target]

    end
  end
  dp_cache.last
end

puts num_squares(12) == 3
puts num_squares(16) == 1
