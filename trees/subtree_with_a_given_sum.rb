# class TreeNode
#   attr_accessor :val, :left, :right

#   def initialize(val)
#       @val = val
#       @left, @right = nil, nil
#   end
# end

# root                 = TreeNode.new(5)
# root.left            = TreeNode.new(4)
# root.right           = TreeNode.new(3)
# root.left.left       = TreeNode.new(3)
# root.left.right      = TreeNode.new(2)
# root.right.left      = TreeNode.new(2)
# root.right.right     = TreeNode.new(1)
# root.left.left.left  = TreeNode.new(2)
# root.left.left.right = TreeNode.new(1)

# tree_level_order = serialize_level_order(root)
# pretty_print(tree_level_order, &expand_missing_leaves)


# t/f + (if found : <value>, otherwise <tree sum>)
def subtree_with_sum(root, sum)
  return [false, 0] unless root

  left = subtree_with_sum(root.left, sum)
  return left if left[-1] == sum

  right  = subtree_with_sum(root.right, sum)
  return right if right[-1] == sum

  current_sum = root.val + left[-1] + right[-1]
  [current_sum == sum, current_sum]
end


[12, 13, 6, 1].each do |n|
  puts "#{n}:\t#{subtree_with_sum(root, n)}"
end

# 12: [true, 12]
# 13: [false, 23]
# 6:  [true, 6]
# 1:  [true, 1]


# t/f + (nodes discovered)
def subtree_with_sum(root, sum, *elements)
  return [false, elements.sum, elements] unless root

  left  = subtree_with_sum(root.left, sum, *elements)
  right = subtree_with_sum(root.right, sum, *elements)
  return left if left.first == true
  return [true, left.last] if left.last.sum == sum
  return right if right.first == true
  return [true, right.last] if right.last.sum == sum

  current_sum = elements.sum + root.val
  [current_sum == sum, [*elements, root.val, *left.last, *right.last]]
end

[12, 13, 6, 1].each do |n|
  res = subtree_with_sum(root, n)
  puts "Subtree with sum #{sum} #{res.first ? 'exists' : 'does not exist'}: #{res.last}"
end

# Subtree with sum 12 exists: [4, 3, 2, 1, 2]
# Subtree with sum 13 does not exist: [5, 4, 3, 2, 1, 2, 3, 2, 1]
# Subtree with sum 6 exists: [3, 2, 1]
# Subtree with sum 1 exists: [1]

