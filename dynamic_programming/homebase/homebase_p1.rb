=begin

Suppose we have some input data describing a graph of relationships between parents and
children over multiple families and generations.
The data is formatted as a list of (parent, child) pairs, where each individual
is assigned a unique positive integer identifier.

For example, in this diagram, 3 is a child of 1 and 2, and 5 is a child of 4:

  1   2   4           30
  \ /   /  \           \
   3   5   9  15       16
   \ / \    \ /
    6   7   12

Sample input/output (pseudo data):
  pairs = [
    (5, 6), (1, 3), (2, 3), (3, 6), (15, 12), (5, 7), (4, 5), (4, 9), (9, 12), (30, 16)
  ]

Write a function that takes this data as input and returns two collections:
  - one containing all individuals with zero known parents,
  - and one containing all individuals with exactly one known parent.
Output may be in any order.

=end

# Space: O(n), Time: O(n)
def find_nodes_with_zero_and_one_parents(pairs)
  parents  = []
  children = []
  parent_count = Hash.new(0)

  pairs.each do |parent, child|
    parents << parent
    children << child
    # count how many times element appears as a child
    parent_count[child] += 1
  end

  # zero parents elements = they are not children of any other parent
  zero_parents = parents - children

  # children with only one parent appear only once in last position
  one_parent   = parent_count
    .select { |_, count| count == 1 }
    .map &:first
  [zero_parents.uniq.sort, one_parent.sort]
end

pairs = [
  [5, 6], [1, 3], [2, 3], [3, 6], [15, 12], [5, 7], [4, 5], [4, 9], [9, 12], [30, 16]
]

#test
puts find_nodes_with_zero_and_one_parents(pairs) == [
  [1, 2, 4, 15, 30], # Individuals with zero parents
  [5, 7, 9, 16]      # Individuals with exactly one parent
] # true