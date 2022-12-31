# https://leetcode.com/problems/find-duplicate-subtrees/
# 
# Find Duplicate Subtrees
# Given the root of a binary tree, return all duplicate subtrees.
# For each kind of duplicate subtrees, you only need to return the root node of any one of them.
# Two trees are duplicate if they have the same structure with the same node values.

serialized_tree  = "0,2,4,N,N,N,3,5,7,N,N,N,6,2,4,N,N,N,9,10,N,N,12,N,13"
tree_root        = deserialize_preorder_dfs(serialized_tree)
tree_level_order = serialize_level_order(tree_root)
pretty_print(tree_level_order, &expand_missing_leaves)

def find_duplicate_subtrees(root)
  duplicates, seen = [], []
  dfs = lambda do |node|
    return "#" if node.nil?

    # generate "subtree sequence" for each node
    subtree_str = "#{node.val}#{dfs[node.left]}#{dfs[node.right]}"

    # increment the count of the subtree string in the hash map
    if seen.detect {|el| el == subtree_str }
      duplicates << node unless duplicates.include?(node)
    else
      seen << subtree_str
    end
    subtree_str
  end

  # traverse the tree and generate the subtree strings
  dfs[root]
  duplicates
end

# level order
def generate_subtree(node)
  return [] unless node
  [node.val, *generate_subtree(node.left), *generate_subtree(node.right)].compact
end

puts serialized_tree
puts find_duplicate_subtrees(tree_root)
  .map { |node| generate_subtree(node) }
  .inspect

# ________________________________________________________________
#                                0
#                2                               3
#        4               •               5               6
#    •       •       •       •       7       •       2       9
#  •   •   •   •   •   •   •   •   •   •   •   •   4   •  10  12
# • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • •13
# ================================================================
# 0,2,4,N,N,N,3,5,7,N,N,N,6,2,4,N,N,N,9,10,N,N,12,N,13

# All possible subtrees of a given tree:
# 4##
# 24###
# 7##
# 57###
# 4##
# 24###
# 10##
# 13##
# 12#13##
# 910##12#13##
# 624###910##12#13##
# 357###624###910##12#13##
# 024###357###624###910##12#13##

# the final answer
# [[4], [2, 4]]
