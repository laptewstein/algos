# Recursive PREORDER DFS de/serialization of a tree.

# deserialize (reconstruct) a tree using preorder traversal (root-left-right).
def deserialize_preorder_dfs(node_values)
  node_values = node_values.split(",")
  idx         = -1
  dfs = -> {
    idx += 1
    node_value = node_values[idx]
    return unless node_value
    return if node_value == 'N'
    node       = TreeNode.new(node_value.to_i)
    node.left  = dfs.call
    node.right = dfs.call
    node
  }
  dfs.call
end

# serialize using preorder traversal (root-left-right).
def serialize_preorder_dfs(root)
  # if tree contains one only root node, return just that
  return root.val.to_s unless root.left || root.right
  node_values = []
  dfs = lambda do |root|
    if root
      node_values << root.val 
      dfs[root.left]
      dfs[root.right]
    else
      node_values << "N"
    end  
  end
  dfs[root]
  node_values[0...-2].join(',') # last two nodes are always going to be nil leaf nodes
end

# RootLeftRight
serialized_tree = '41,30,26,N,N,32,N,N,55,51,47,45,N,N,48,N,N,52,N,N,69,64,N,N,72,N,76'

# puts pretty_print(serialized_tree, &expand_missing_leaves)
# ________________________________________________________________
#                               41
#               30                              55
#       26              32              51              69
#    •       •       •       •      47      52      64      72
#  •   •   •   •   •   •   •   •  45  48   •   •   •   •   •  76
# ================================================================
# 41,30,55,26,32,51,69,N,N,N,N,47,52,64,72,45,48,N,N,N,N,N,76

# a) =============================
# from string into on object
# preorder: root - left - right
tree_root        = deserialize_preorder_dfs(serialized_tree)

# display: level order
# -- 1. turn an object into a (level-order) string 
# -- 2. feed into a (level-order) printing mechanism
tree_level_order = serialize_level_order(tree_root)
pretty_print(tree_level_order, &expand_missing_leaves)

# ________________________________________________________________
#                               41
#               30                              55
#       26              32              51              69
#    •       •       •       •      47      52      64      72
#  •   •   •   •   •   •   •   •  45  48   •   •   •   •   •  76
# ================================================================

# b) =============================
# from object to a string 
# preorder: root - left - right 
tree_preorder    = serialize_preorder_dfs(tree_root)
puts serialized_tree == tree_preorder # => true
 
# c) ============================= (extra verification)
# from string into on object
# preorder: root - left - right
tree_root        = deserialize_preorder_dfs(tree_preorder)

# display: level order
# -- 1. turn an object into a (level-order) string 
# -- 2. feed into a (level-order) printing mechanism
tree_level_order = serialize_level_order(tree_root)
pretty_print(tree_level_order, &expand_missing_leaves)

# ________________________________________________________________
#                               41
#               30                              55
#       26              32              51              69
#    •       •       •       •      47      52      64      72
#  •   •   •   •   •   •   •   •  45  48   •   •   •   •   •  76
# ================================================================

