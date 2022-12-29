# padded serialization (nil nodes children grow as we get closer to the base)
# NOTE: not a leetcode serialization due to required padding (nil values)

# ---------------------
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val)
      @val = val
      @left, @right = nil, nil
  end
end
# ---------------------

# hydrate (recreate) a tree from a string
def deserialize_padded_level_order(sequence, nil_value: 'N', separator: ",")
  node_values = sequence
    .split(separator)
    .map { |node_value| node_value.to_i unless node_value == nil_value } # integer or nil
  # puts node_values.inspect
  root_node_value     = node_values.first
  return unless root_node_value # takes care of nil and 'N'

  root                = TreeNode.new(root_node_value)
  last_iterable_index = node_values.size - 2

  root.tap do |root_node|
    queue = [root_node]

    puts node_values.inspect # values there

    # next index of node value
    idx = -1 # 0 => root, 1 => left, 2 => right
    until queue.empty? || idx > last_iterable_index
      idx += 2
      head = queue.shift
      # push nil values into queue to account for index icrease
      # otherwise we stop iteration before accessig children in unbalanced trees
      next unless head 
      left_node_value, right_node_value = node_values[idx], node_values[idx.succ]

      # there might be case when only left or only right leaf node exists
      head.left = TreeNode.new(left_node_value) if left_node_value
      queue << head.left

      head.right = TreeNode.new(right_node_value) if right_node_value
      queue << head.right
    end
  end
end

# serialize a tree (dehydrate into a string)
def serialize_tree_level_order(root, nil_value: 'N', separator: ',')
  queue, output = [root], []
  until queue.all? { |elem| elem.nil? } # until the queue is not empty
    current = queue.shift
    if current.nil?            # no node?
      output << nil_value
      2.times { queue << nil } # each empty node has 2 empty children
    else
      queue << (current.left if current.left)   # left
      queue << (current.right if current.right) # right
      output << current.val                     # store value to output
    end
  end
  output.join(separator)
end


unbalanced_bigger_tree = [
  41, 30, 55, 26, 32, 51, 69, nil, nil, nil, nil, 47, 52, 64, 
  72, nil, nil, nil, nil, nil, nil, nil, nil, 45, 48, nil, nil, 
  nil, nil, nil, 76
].map { |v| v || 'N' }.join(",")
tree = deserialize_padded_level_order(unbalanced_tree)


serialized_tree = "3,5,1,6,2,0,8,N,N,7,4"
tree_root       = deserialize_level_order(serialized_tree)
tree            = serialize_tree_level_order(tree_root)

puts pretty_print(tree)
puts "BFS traversal (retain queue): #{tree}"
# ________________________________________________________________
#                                3
#                5                               1
#        6               2               0               8
#    •       •       7       4       •       •       •       •
#  •   •   •   •   •   •   •   •   •   •   •   •   •   •   •   •
# ================================================================
# 3,5,1,6,2,0,8,N,N,7,4,N,N,N,N,N,N,N,N
# BFS traversal (drain queue): 3,5,1,6,2,0,8,N,N,7,4,N,N,N,N,N,N,N,N

# ________________________________
#                3
#        5               1
#    6       2       0       8
#  •   •   7   4   •   •   •   •
# ================================
# 3,5,1,6,2,0,8,N,N,7,4
# BFS traversal (retain queue): 3,5,1,6,2,0,8,N,N,7,4


# another attempt of serialization (dehydration, compression for archival/transmisson)
def serialize_level_order(root, nil_value: 'N', separator: ',')
  serialization = []
  queue = [root]
  until queue.empty?
    member = queue.shift
    if member
      serialization << member.val
      queue << member.left
      queue << member.right
    else
      serialization << nil_value
    end
  end
  serialization.join(separator)
end

tree = serialize_level_order(tree_root)
puts pretty_print(tree)
puts "BFS traversal (drain queue): #{tree}"


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
