# count number of non-nil nodes
def tree_size(root)
  queue = [root]
  count = 0
  until queue.empty?
    node = queue.shift
    next if node.nil?
    count += 1
    queue << node.left
    queue << node.right
  end
  count
end

puts "Tree Size: #{tree_size(tree)} nodes"
puts tree_size(tree) == unbalanced_bigger_tree.compact.count # => 14


# longest chain of non-empty nodes, 0 if only root is present.
def tree_depth(root, depth = 0)
  return depth unless root
  return depth if root.left.nil? && root.right.nil?
  [tree_depth(root.left, depth.succ), tree_depth(root.right, depth.succ)].max
end


# longest chain of non-empty nodes, 0 if only root is present.
def tree_max_height(root)
  return 0 unless root
  return 0 if root.left.nil? && root.right.nil?
  1 + [tree_depth(root.left), tree_depth(root.right)].max
end

puts "Tree Depth: #{tree_depth(tree)} levels"
[tree, tree.left, tree.right].each do |node|
  puts tree_depth(node) == tree_max_height(node)
end


# tree is considered balanced when their depth difference does not exceed 1 
# nodes may be allowed to have leaves (children) but not <children of children>
def is_balanced?(root, strict: false)
  return -1 unless root
  diff = tree_depth(root.left) - tree_depth(root.right)
  return diff == 0 if strict
  diff < 2 && diff > -2
end

puts "Is tree height-balanced? #{is_balanced?(tree)}"
puts is_balanced?(tree)                           # => false
puts is_balanced?(tree.left)                      # => true
puts is_balanced?(tree.right)                     # => true
puts is_balanced?(tree.right.right, strict: true) # => false
puts is_balanced?(tree.right.right)               # => true


# pretty_print(unbalanced_tree)
# ________________________________________________________________
#                               41
#               30                              55
#       26              32              51              69
#    •       •       •       •      47      52      64      72
#  •   •   •   •   •   •   •   •  45  48   •   •   •   •   •  76
# ================================================================
# # 41,30,55,26,32,51,69,N,N,N,N,47,52,64,72,N,N,N,N,N,N,N,N,45,48,N,N,N,N,N,76

# Tree Size: 14 nodes
# true

# Tree Depth: 4 levels
# true
# true
# true

# Is tree height-balanced? false
# false
# true
# true
# false
# true

#------------------------------------------
def invert_tree(root)
  return unless root
  root.left, root.right = root.right, root.left
  invert_tree(root.right)
  invert_tree(root.left)
  root
end

# serialized_tree = '41,30,55,26,32,51,69,N,N,N,N,47,52,64,72,45,48,N,N,N,N,N,76'
# puts pretty_print(serialized_tree, &expand_missing_leaves)
# ________________________________________________________________
#                               41
#               30                              55
#       26              32              51              69
#    •       •       •       •      47      52      64      72
#  •   •   •   •   •   •   •   •  45  48   •   •   •   •   •  76
# ================================================================
# 41,30,55,26,32,51,69,N,N,N,N,47,52,64,72,45,48,N,N,N,N,N,76


# tree_root     = deserialize_level_order(serialized_tree)
# inverted_tree = invert_tree(tree_root)
# tree          = serialize_level_order(inverted_tree)
# puts pretty_print(tree, &expand_missing_leaves)

# ________________________________________________________________
#                               41
#               55                              30
#       69              51              32              26
#   72      64      52      47       •       •       •       •
# 76   •   •   •   •   •  48  45   •   •   •   •   •   •   •   •
# ================================================================
# 41,55,30,69,51,32,26,72,64,52,47,N,N,N,N,76,N,N,N,N,N,48,45

