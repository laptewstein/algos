# https://leetcode.com/problems/range-addition/
# Range Addition

# Assume you have an array of length n initialized with all 0's and are given k update operations.

# Each operation is represented as a triplet: [startIndex, endIndex, inc]
#  which increments each element of subarray A[startIndex ... endIndex] (startIndex and endIndex inclusive) with inc.

# Return the modified array after all k operations were executed.

def getModifiedArray(length, updates)
  compressed_updates = [0] * length

  # (1) compress!
  for update in updates
    upd_start, upd_end, delta = update

    # apply update for the first index
    compressed_updates[upd_start] += delta

    # if update is only partial (ends sooner than last index),
    # apply NEGATED update on the following index after last
    compressed_updates[upd_end.succ] -= delta unless upd_end == length.pred
  end

  # (2) aggregate!
  # starting with index 1, apply pending changes to all indices by INCR/DECR each, using values from previous indices
  compressed_updates.tap do |aggregation|
    for idx in 1...length
      aggregation[idx] += aggregation[idx.pred]
    end
  end
end

updates = [
  [1,  3,  2],
  [2,  4,  3],
  [0,  2, -2]
]

puts getModifiedArray(5, updates) == [-2, 0, 3, 5, 3]

# Explanation:

# Initial state:
# [ 0, 0, 0, 0, 0 ]

# After applying operation [1, 3, 2]:
# [ 0, 2, 2, 2, 0 ] # add +2 for indices 1 to 3

# After applying operation [2, 4, 3]:
# [ 0, 2, 5, 5, 3 ] # add +3 for indices 2 to 4

# After applying operation [0, 2, -2]:
# [-2, 0, 3, 5, 3 ] # subtract 2 from indices 0 to 2

# ========
# (1) compressing updates into one line

# [0, 0, 0, 0, 0]
# [0, 2, 0, 0, -2]
# [0, 2, 3, 0, -2]
# [-2, 2, 3, 2, -2]

# (2a) Applying pending changes

# [-2, 0, 3, 2, -2]
# [-2, 0, 3, 2, -2]
# [-2, 0, 3, 5, -2]
# [-2, 0, 3, 5, 3]

# (2b) Or alternatively, create new aggregation array instead of modifying one in place:
# [-2, 0, 0, 0, 0]
# [-2, 0, 3, 0, 0]
# [-2, 0, 3, 5, 0]
# [-2, 0, 3, 5, 3]

# ==========
# true => [-2, 0, 3, 5, 3]

