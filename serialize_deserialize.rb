# ------------
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val)
      @val = val
      @left, @right = nil, nil
  end
end
# ------------

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

# ________________________________________________________________
#                                3
#                5                               1
#        6               2               0               8
#    •       •       7       4       •       •       •       •
#  •   •   •   •   •   •   •   •   •   •   •   •   •   •   •   •
# ================================================================
# 3,5,1,6,2,0,8,N,N,7,4,N,N,N,N,N,N,N,N
# BFS traversal (drain queue): 3,5,1,6,2,0,8,N,N,7,4,N,N,N,N,N,N,N,N


