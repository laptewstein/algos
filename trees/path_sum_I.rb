# https://leetcode.com/problems/path-sum

# Given the root of a binary tree and an integer targetSum, 
# return true if the tree has a root-to-leaf path such that adding up all the values along the path equals targetSum.
# A leaf is a node with no children.

def has_path_sum(root, target_sum)
    return false unless root
    return true if target_sum == root.val && root.left.nil? && root.right.nil?
    left = has_path_sum(root.left, target_sum - root.val)
    return true if left == true
    has_path_sum(root.right, target_sum - root.val) == true
end
