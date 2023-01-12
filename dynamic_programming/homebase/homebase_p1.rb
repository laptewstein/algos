=begin
Suppose we have some input data describing a graph of relationships between parents and
children over multiple families and generations.
The data is formatted as a list of (parent, child) pairs, where each individual
is assigned a unique positive integer identifier.

For example, in this diagram, 3 is a child of 1 and 2, and 5 is a child of 4:

  1   2    4           30
  \ /   /  \           \
   3   5    9  15      16
   \ / \    \ /
    6   7   12

Sample input/output (pseudodata):
  pairs = [
    (5, 6), (1, 3), (2, 3), (3, 6), (15, 12),
    (5, 7), (4, 5), (4, 9), (9, 12), (30, 16)
  ]

Write a function that takes this data as input and returns two collections: one containing all individuals with zero known parents, and one containing all individuals with exactly one known parent.


Output may be in any order:

findNodesWithZeroAndOneParents(pairs) => [
  [1, 2, 4, 15, 30],   // Individuals with zero parents
  [5, 7, 9, 16]        // Individuals with exactly one parent
]

Complexity Analysis variables:
  n: number of pairs in the input
=end

pairs = [
  [5, 6], [1, 3], [2, 3], [3, 6], [15, 12],
  [5, 7], [4, 5], [4, 9], [9, 12], [30, 16]
]

# Space: O(n), Time: O(n)
def findNodesWithZeroAndOneParents(pairs)
  # all known parents
  parents          = pairs.map {|p, _| p }
  child_to_parents = Hash.new(0)

  pairs.each do |p, c|
    child_to_parents[c] += 1
  end

  one_parent   = child_to_parents.select { |k, v| v == 1 }.map {|a, _| a }
  zero_parents = (parents - child_to_parents.keys).uniq
  [zero_parents, one_parent]
end

# puts findNodesWithZeroAndOneParents(pairs).inspect
# [[1, 2, 15, 4, 30], [7, 5, 9, 16]]