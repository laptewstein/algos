# https://leetcode.com/problems/populating-next-right-pointers-in-each-node
# Binary Tree Next Node

#   A typical binary tree node has two members, left and right.  
#   Imagine a tree node that has  * an additional member called "next".  
#   This member would point to the next node to the right  on the same 
#   tree level as the given node, regardless of parent.  

#   Given a valid binary tree with unpopulated "next" nodes, 
#   write a function to populate the "next" nodes for the tree.


# DFS, O(n) space due to recursion
def connect(root)
  return if root.nil?
  
  # not a leaf node (has children)
  root.left.next = root.right if root.left
  
  # onn level 2 and below, root.next has been taken care of on previous step
  root.right.next = root.next.left if root.next 
  end
  connect(root.left)
  connect(root.right)
  root
end

# level order, O(1) space
def connect(root)
  node                     = root 
  first_node_of_next_level = root.left if root # there might be no root!
  while node && first_node_of_next_level
    node.left.next  = node.right
    node.right.next = node.next.left if node.next

    node = node.next
    # go down one level if last node of current level has been updated
    unless node
      node                     = first_node_of_next_level
      first_node_of_next_level = node.left
    end
  end
  root
end
