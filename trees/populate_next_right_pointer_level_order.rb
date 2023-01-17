# https://leetcode.com/problems/populating-next-right-pointers-in-each-node
# Binary Tree Next Node

#   A typical binary tree node has two members, left and right.  
#   Imagine a tree node that has  * an additional member called "next".  
#   This member would point to the next node to the right  on the same 
#   tree level as the given node, regardless of parent.  

#   Given a valid binary tree with unpopulated "next" nodes, 
#   write a function to populate the "next" nodes for the tree.

# see https://github.com/Kartoshka548/algos/blob/master/trees/NextNodeBinaryTree.png
# ________________________________________________________________
#                                A
#               B               ->             C
#       D      ->      E                ->             G
#    H     •        •     •     ->    •     •       I     •
# ================================================================

# level order, [process entire level]
def connect_bfs(root)
  return unless root

  queue = [root]
  until queue.empty?
    previous = nil
    queue.size.times do
      node          = queue.shift
      previous.next = node if previous
      previous      = node
      # populate carousel with current level children nodes
      queue << node.left   if node.left
      queue << node.right  if node.right
    end
  end
  root
end

# DFS, O(n) space due to recursion
def connect_dfs(root)
  # helper method
  get_next_child = lambda do |node|
    next_node = node.next
    while next_node
      return next_node.left  if next_node.left
      return next_node.right if next_node.right

      next_node = next_node.next
    end
  end

  # recursive
  connect = lambda do |node|
    return unless node

    node.left.next  = node.right || get_next_child[node] if node.left
    node.right.next = get_next_child[node]               if node.right

    connect[node.left]
    connect[node.right]
  end

  connect[root]
end

# tests
[:connect_dfs, :connect_bfs].each do |meth|
  class TreeNode
    attr_accessor :val, :left, :right, :next

    def initialize(val, next_val = nil)
      @val = val
      @next = next_val
      @left, @right = nil, nil
    end
  end

  # Nodes
  root   = TreeNode.new("A")
  b      = TreeNode.new("B")
  c      = TreeNode.new("C")
  d      = TreeNode.new("D")
  e      = TreeNode.new("E")
  g      = TreeNode.new("G")
  c.right = g
  d.left  = TreeNode.new("H")
  g.left  = TreeNode.new("I")
  b.left  = d
  b.right = e
  root.left  = b
  root.right = c

  send(meth, root)

  puts b.next == c                      # true
  puts d.next == e                      # true
  puts d.next.next.val == ?G            # true
  puts d.left.next == g.left            # true
  puts d.next.next.next === g.left.next # true
end

# # technique below will only work for lab-grown,
# # perfect trees (each node always has 2 children)
# # Space: O(1)
# def connect_o_one(root)
#   node                     = root
#   first_node_of_next_level = root.left if node # there might be no root!
#   while node && first_node_of_next_level
#     node.left.next  = node.right
#     node.right.next = node.next.left if node.next
#
#     node = node.next
#     # go down one level if last node of current level has been updated
#     unless node
#       node                     = first_node_of_next_level
#       first_node_of_next_level = node.left
#     end
#   end
#   root
# end
