# https://leetcode.com/problems/search-in-a-binary-search-tree
# Search in a Binary Search Tree
# You are given the root of a binary search tree (BST) and an integer val.
#
# Find the node in the BST that the node's value equals val and return the subtree
# rooted with that node. If such a node does not exist, return null.


#  +


# https://leetcode.com/problems/insert-into-a-binary-search-tree
# Insert into a Binary Search Tree
#
# Given the root node of a binary search tree (BST) and a value to be
# inserted into the tree, insert the value into the BST. Return the
# root node of the BST after the insertion.
#
# It is guaranteed that the new value DOES NOT EXIST in the original BST.
#
# For example,
#
# Given the tree:
# ⁠       4
# ⁠      / \
# ⁠     2   7
# ⁠    / \
# ⁠   1   3
# And the value to insert: 5

# You can return this binary search tree:
#
# ⁠        4
# ⁠      /   \
# ⁠     2     7
# ⁠    / \   /
# ⁠   1   3 5

# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end

def insert_into_bst(root, val)
  return TreeNode.new(val) unless root
  # 1   <=> 7 => -1
  # 7   <=> 7 => 0 # guaranteed not to be present but even if it did, its root val
  # 10  <=> 7 => 1
  # []  <=> 7 => nil (incomparable)
  case val <=> root.val
  when -1
    root.left = insert_into_bst(root.left, val)
  when 1
    root.right = insert_into_bst(root.right, val)
  when nil
    raise StandardError, "incomparable values"
  end
  root
end

def search_bst(root, val)
  return unless root
  case val <=> root.val
  when -1
    search_bst(root.left, val)
  when 0
    root
  when 1
    search_bst(root.right, val)
  end
end