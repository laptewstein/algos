=begin
  # https://www.geeksforgeeks.org/evaluation-of-expression-tree/
  Given a simple expression tree consisting of basic binary operators 
  i.e +, –, * and / with integer leaf nodes, evaluate the expression tree.
  
  Suppose an arithmetic expression is given as a binary tree. 
  Each leaf is an integer and each internal node is one of '+', '−', '∗', or '/'.
  
  Given the root to such a tree, write a function to evaluate it.
  For example, given the following tree:
      *
     / \
    +    +
   / \  / \
  3  2  4  5
  You should return 45, as it is (3 + 2) * (4 + 5).
=end
class Node
  attr_accessor :data, :left, :right
  def initialize(value)
    @data  = value
    @left  = nil
    @right = nil
  end

  def self.evaluateExpressionTree(root)
    return 0 unless root
    return root.data.to_i unless root.left  || root.right
        
    left_sum = evaluateExpressionTree(root.left)
    right_sum = evaluateExpressionTree(root.right)

    case root.data
      when '+'
        return left_sum + right_sum
      when '-'
        return left_sum - right_sum
      when '*'
        return left_sum * right_sum
      when '/'
        return left_sum / right_sum
      else
        raise StandardError, 'undefined'  
    end
  end    
end

# sample tree: https://github.com/laptewstein/algos/blob/master/trees/pic21-300x224.png?raw=true
root = Node.new('+')
root.left = Node.new('*')
root.left.left = Node.new('5')
root.left.right = Node.new('4')
root.right = Node.new('-')
root.right.left = Node.new('100')
root.right.right = Node.new('20')
puts Node.evaluateExpressionTree(root) # 100


# sample tree: https://github.com/laptewstein/algos/blob/master/trees/pic11-300x259.png

root = Node.new('+')
root.left = Node.new('*')
root.left.left = Node.new('5')
root.left.right = Node.new('4')
root.right = Node.new('-')
root.right.left = Node.new('100')
root.right.right = Node.new('/')
root.right.right.left = Node.new('20')
root.right.right.right = Node.new('2')
puts Node.evaluateExpressionTree(root) # 110

# ======================================================= #
# python:
class Node:
  def __init__(self, value):
    self.data = value
    self.left = None
    self.right = None


def evaluateExpressionTree(root):
  if root is None:
      return 0

  # leaf node
  if root.left is None and root.right is None:
      return int(root.data)

  # evaluate left tree
  left_sum = evaluateExpressionTree(root.left)

  # evaluate right tree
  right_sum = evaluateExpressionTree(root.right)

  # check which operation to apply
  if root.data == '+':
      return left_sum + right_sum
  elif root.data == '-':
      return left_sum - right_sum
  elif root.data == '*':
      return left_sum * right_sum
  else:
      return left_sum // right_sum


# Sample tree
root = node('+')
root.left = node('*')
root.left.left = node('5')
root.left.right = node('4')
root.right = node('-')
root.right.left = node('100')
root.right.right = node('20')
print (evaluateExpressionTree(root)) # 100

# Another sample tree
root = Node('+')
root.left = Node('*')
root.left.left = Node('5')
root.left.right = Node('4')
root.right = Node('-')
root.right.left = Node('100')
root.right.right = Node('/')
root.right.right.left = Node('20')
root.right.right.right = Node('2')
print(evaluateExpressionTree(root)) # 110
