# leetcode style serialization

# ------------
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val)
      @val = val
      @left, @right = nil, nil
  end
end
# ------------

def serialize_level_order(root, nil_value: 'N', separator: ',')
  serialization = []
  queue = [root]
  until queue.all? { |elem| elem.nil? }
    member = queue.shift
    if member
      serialization << member.val
      queue << member.left << member.right
    else
      serialization << nil_value
    end
  end
  serialization.join(separator)
end

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
    idx = 1 # 0 => root, 1 => left, 2 => right

    until queue.empty?
      head = queue.shift
      left_node_value, right_node_value = node_values[idx], node_values[idx.succ]

      # there might be case when only left or only right leaf node exists
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

# tests
tree1           = [
  41, 30, 55, 26, 32, 51, 69, nil, nil, nil, nil, 47,
  52, 64, 72, 45, 48, nil, nil, nil, nil, nil, 76]
tree_root = deserialize_level_order(tree1.map { |v| v || 'N' }.join(","))
tree      = serialize_level_order(tree_root)
puts pretty_print(tree, &expand_missing_leaves)

tree2           = "3,5,1,6,2,0,8,N,N,7,4" 
tree_root       = deserialize_level_order(tree2) 
tree            = serialize_level_order(tree_root) 
puts pretty_print(tree) # no need for expansion!
 
tree3         = [5,4,7,3,nil,2,nil,-1,nil,9]
tree_root     = deserialize_level_order(tree3.map { |v| v || 'N' }.join(","))
tree          = serialize_level_order(tree_root)
puts pretty_print(tree, &expand_missing_leaves)

# ________________________________________________________________
#                               41
#               30                              55
#       26              32              51              69
#    •       •       •       •      47      52      64      72
#  •   •   •   •   •   •   •   •  45  48   •   •   •   •   •  76
# ================================================================
# 41,30,55,26,32,51,69,N,N,N,N,47,52,64,72,45,48,N,N,N,N,N,76

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
# 5,4,7,3,N,2,N,-1,N,9
