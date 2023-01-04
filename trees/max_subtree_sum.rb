https://leetcode.com/problems/binary-tree-maximum-path-sum/

# A path in a binary tree is a sequence of nodes where each pair of adjacent nodes in the sequence has an edge connecting them. A node can only appear in the sequence at most once. Note that the path does not need to pass through the root.
# The path sum of a path is the sum of the node's values in the path.
# Given the root of a binary tree, return the maximum path sum of any non-empty path.

def max_path_sum(root)
  res = [root.val]
  dfs = lambda do |root|
    return 0 unless root

    left_max  = [0, dfs[root.left]].max
    right_max = [0, dfs[root.right]].max
    # with_split
    with_split = root.val + left_max + right_max
    res[0] = with_split if with_split > res.first
    root.val + [left_max, right_max].max
  end
  dfs[root]
  res.first
end

# alternative
def max_path_sum(root)
  return unless root
  @max_sum = root.val
  find_max_sum(root)
  return @max_sum
end

def find_max_sum(node)
  return 0 if node.nil?
  left_sum = [0, find_max_sum(node.left)].max
  right_sum = [0, find_max_sum(node.right)].max
  @max_sum = [@max_sum, left_sum + right_sum + node.val].max
  return [node.val + left_sum, node.val + right_sum].max
end

