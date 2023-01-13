=begin

Suppose we have some input data describing a graph of relationships between parents and
children over multiple generations. The data is formatted as a list of (parent, child) pairs,
where each individual is assigned a unique positive integer identifier.

For example, in this diagram, 6 and 8 have common ancestors of 4 and 14.

               15
              / \
         14  13  21
         |   |
1   2    4   12
 \ /   / | \ /
  3   5  8  9
  \ / \     \
   6  7     11

pairs = [
  (1, 3), (2, 3), (3, 6), (5, 6), (5, 7), (4, 5), (15, 21), 
  (4, 8), (4, 9), (9, 11), (14, 4), (13, 12), (12, 9), (15, 13)
]

Write a function that takes this data and the identifiers of two individuals as inputs
and returns true if and only if they share at least one ancestor.

=end

# Space: O(n), Time: O(n)
# depth first search (DFS) due to parent node exploration
def has_common_ancestor(pairs, a, b)
  ancestors = {}
  parents = []

  # for each child, build ancestry tree
  pairs.each do |parent, child|
    parents << parent
    ancestors[child] ||= []
    ancestors[child] << parent
  end

  dfs = lambda do |node|
    node_ancestry = []
    queue         = [node]
    until queue.empty?
      node = queue.pop
      node_parents = ancestors[node]
      # top level node will have no parents
      next unless node_parents

      node_parents.each do |parent|
        node_ancestry << parent
        # explore parents ancestry
        queue << parent
      end
    end
    node_ancestry
  end

  (dfs[a] & dfs[b]).count > 0
end

pairs = [
  [1, 3], [2, 3], [3, 6], [5, 6], [5, 7], [4, 5], [15, 21],
  [4, 8], [4, 9], [9, 11], [14, 4], [13, 12], [12, 9], [15, 13]
]

# tests
puts has_common_ancestor(pairs, 3, 8)   # => false
puts has_common_ancestor(pairs, 5, 8)   # => true
puts has_common_ancestor(pairs, 6, 8)   # => true
puts has_common_ancestor(pairs, 6, 9)   # => true
puts has_common_ancestor(pairs, 1, 3)   # => false
puts has_common_ancestor(pairs, 3, 1)   # => false
puts has_common_ancestor(pairs, 7, 11)  # => true
puts has_common_ancestor(pairs, 6, 5)   # => true
puts has_common_ancestor(pairs, 5, 6)   # => true
puts has_common_ancestor(pairs, 3, 6)   # => true
puts has_common_ancestor(pairs, 21, 11) # => true

