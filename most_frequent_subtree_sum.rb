# https://leetcode.com/problems/most-frequent-subtree-sum

# Most Frequent Subtree Sum
# Given the root of a binary tree, return the most frequent subtree sum. If there is a tie, return all the values with the highest frequency in any order.
# The subtree sum of a node is defined as the sum of all the node values formed by the subtree rooted at that node (including the node itself).

def find_frequent_tree_sum(root)
    return [] unless root
    frequencies = Hash.new(0)

    dfs = lambda do |node|
      return 0 unless node
      subtree_sum = node.val + dfs.call(node.left) + dfs.call(node.right)
      frequencies[subtree_sum] += 1
      subtree_sum
    end

    dfs[root]
    max = frequencies.values.max
    frequencies
      .select {|k, v| v == max}
      .map(&:first)
end
