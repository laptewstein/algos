# visualize a search tree
#               5
#       2               6
#   1       4       •       8
# •   •   3   •   •   •   7   9
def pretty_print(serialized_tree, nil_value: 'N', separator: ",")
  # split 1D array ito n-D array, a tree with [root, [2 * child nodes], [4 * children] ...]
  splt_array_into_levels = lambda do |node_values|
    tree, level = [], []
    level_idx     = tree.size
    level_members = 2 ** level_idx
    node_values.each do |node_value|
      level << node_value
      next unless level.size == level_members

      tree << level
      level          = []
      level_members *= 2
      level_idx     += 1
    end
    # dangling level, fill missing slots with nulls
    if level.size > 0
      level << nil until level.size == level_members
      tree << level
    end
    tree
  end

  cleansed_node_values = serialized_tree
  .split(separator)
  .map { |node_value| node_value.to_i unless node_value == nil_value } # integer or nil
  return unless cleansed_node_values.size > 0
  tree = splt_array_into_levels.call(cleansed_node_values)
  
  # total space in the last level (max spacing of each node: 3)
  max_width = tree.last.length * 4

  # expects nD array, a tree with [root, [2 * child nodes], [4 * n]...]
  print_tree = lambda do |tree|
    tree.each_with_index do |subarray, level|
      indent = max_width / (2 ** level.succ)
      spacer = max_width / (2 ** level)
      subarray.each_with_index do |element, idx|
        element = "•" unless element
        printf("%*s", idx == 0 ? indent : spacer, element)
      end
      printf("\n")
    end
  end

  puts "_" * max_width
  print_tree[tree]
  puts "=" * max_width
  serialized_tree
end

puts pretty_print("5,2,6,1,4,N,8,N,N,3,N,N,N,7,9")
puts pretty_print("3,5,1,6,2,0,8,N,N,7,4") # auto-fills remaining nil values

# ________________________________
#                5
#        2               6
#    1       4       •       8
#  •   •   3   •   •   •   7   9
# ================================
# 5,2,6,1,4,N,8,N,N,3,N,N,N,7,9
# ________________________________
#                3
#        5               1
#    6       2       0       8
#  •   •   7   4   •   •   •   •
# ================================
# 3,5,1,6,2,0,8,N,N,7,4

# ------------
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val)
      @val = val
      @left, @right = nil, nil
  end
end

# BFS - create, queue, pop left
# hydrate (recreate) a tree from a string
def deserialize_level_order(sequence, nil_value: 'N', separator: ",")
  node_values = sequence
    .split(separator)
    .map { |node_value| node_value.to_i unless node_value == nil_value } # integer or nil
  # puts node_values.inspect
  root_node_value = node_values.first
  return unless root_node_value # takes care of nil and 'N'

  root = TreeNode.new(root_node_value)
  root.tap do |root_node|
    queue = [root_node]

    # next index of node value
    idx   = queue.size # 0 => root, 1 => left, 2 => right
    until queue.empty?
      head = queue.shift
      left_node_value, right_node_value = node_values[idx], node_values[idx.succ]

      # there might be case when only left or only right leaf node  exists
      if left_node_value
        head.left = TreeNode.new(left_node_value)
        queue << head.left
      end
      if right_node_value
        head.right = TreeNode.new(right_node_value)
        queue << head.right
      end
      idx += 2
    end
  end
end

serialized_tree = "3,5,1,6,2,0,8,N,N,7,4"
tree_root       = deserialize_level_order(serialized_tree)

# serialize a tree
def serialize_tree_level_order(root, nil_value: 'N', separator: ',')
  queue, output = [root], []
  until queue.all? { |elem| elem.nil? } # until the queue is not empty
    current = queue.shift
    if current.nil?            # no node?
      output << nil_value
      2.times { queue << nil } # each empty node has 2 empty childern
    else
      queue << (current.left if current.left)   # left
      queue << (current.right if current.right) # right
      output << current.val                     # store value to output
    end
  end
  output.join(separator)
end

tree = serialize_tree_level_order(tree_root)
puts pretty_print(tree)
puts "BFS traversal (retain queue): #{tree}"

# ________________________________
#                3
#        5               1
#    6       2       0       8
#  •   •   7   4   •   •   •   •
# ================================
# 3,5,1,6,2,0,8,N,N,7,4
# BFS traversal (retain queue): 3,5,1,6,2,0,8,N,N,7,4

# another attempt
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

# ________________________________________________________________
#                                3
#                5                               1
#        6               2               0               8
#    •       •       7       4       •       •       •       •
#  •   •   •   •   •   •   •   •   •   •   •   •   •   •   •   •
# ================================================================
# 3,5,1,6,2,0,8,N,N,7,4,N,N,N,N,N,N,N,N
# BFS traversal (drain queue): 3,5,1,6,2,0,8,N,N,7,4,N,N,N,N,N,N,N,N

