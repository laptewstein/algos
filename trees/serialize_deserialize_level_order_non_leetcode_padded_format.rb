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
def deserialize_level_order(sequence, nil_value: 'N', separator: ",")
  node_values = sequence
    .split(separator)
    .map { |node_value| node_value.to_i unless node_value == nil_value } # integer or nil
  root_node_value     = node_values.first
  return unless root_node_value # takes care of nil and 'N'

  root                = TreeNode.new(root_node_value)
  last_iterable_index = node_values.size - 2

  root.tap do |root_node|
    queue = [root_node]

    # next index of node value
    # 0 => root, 1 => left, 2 => right
    idx = -1 
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
def serialize_level_order(root, nil_value: 'N', separator: ',')
  queue, output = [root], []
  until queue.all? { |elem| elem.nil? }
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

tree1 = [
  41, 30, 55, 26, 32, 51, 69, nil, nil, nil, nil, 47, 52, 64, 
  72, nil, nil, nil, nil, nil, nil, nil, nil, 45, 48, nil, nil, 
  nil, nil, nil, 76
]

tree_root = deserialize_level_order(tree1.map { |v| v || 'N' }.join(","))
tree      = serialize_level_order(tree_root)
puts pretty_print(tree)

tree2           = "3,5,1,6,2,0,8,N,N,7,4" 
tree_root       = deserialize_level_order(tree2) 
tree            = serialize_level_order(tree_root)
puts pretty_print(tree)
 
tree3         = [5, 4, 7, 3, nil, 2, nil, -1, nil, nil, nil, 9]
tree_root     = deserialize_level_order(tree3.map { |v| v || 'N' }.join(","))
tree          = serialize_level_order(tree_root)
puts pretty_print(tree)

# ________________________________________________________________
#                               41
#               30                              55
#       26              32              51              69
#    •       •       •       •      47      52      64      72
#  •   •   •   •   •   •   •   •  45  48   •   •   •   •   •  76
# ================================================================
# 41,30,55,26,32,51,69,N,N,N,N,47,52,64,72,N,N,N,N,N,N,N,N,45,48,N,N,N,N,N,76
# ________________________________
#                3
#        5               1
#    6       2       0       8
#  •   •   7   4   •   •   •   •
# ================================
# 3,5,1,6,2,0,8,N,N,7,4
# ________________________________
#                5
#        4               7
#    3       •       2       •
# -1   •   •   •   9   •   •   •
# ================================
# 5,4,7,3,N,2,N,-1,N,N,N,9
