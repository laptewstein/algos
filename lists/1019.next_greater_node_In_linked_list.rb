# https://leetcode.com/problems/next-greater-node-in-linked-list

# 1019. Next Greater Node In Linked List

class ListNode
  attr_accessor :next, :value

  def initialize(value, next_node = nil)
    @value = value
    @next  = next_node
  end

  def to_s
    @value.inspect
  end
end

class LinkedList
  attr_accessor :head

  def initialize(arg)
    @head = arg.is_a?(ListNode) ? arg : ListNode.new(arg)
    @head
  end

  def tail
    node = @head
    while node.next
      node = node.next
    end
    node
  end  

  def append(value)
    tail.next = ListNode.new(value)
  end

  # You are given the head of a linked list with n nodes.
  # For each node in the list, find the value of the next greater node. 
  # That is, for each node, find the value of the first node that is next to 
  # it and has a strictly larger value than it.
  
  # Return an integer array answer where answer[i] is the value of the 
  # next greater node of the ith node (1-indexed). 
  # If the ith node does not have a next greater node, set answer[i] = 0.

  def next_larger_nodes(head = nil)
    node, res, stack = head || @head, [], []
     
    while node
      # for each new node, make sure there are no lower values kept in stack
      # if any value in stack is lesser than current,
      #   reference corresponding <index of result array> 
      #   to point to <current node value>,
      #   and remove it from the stack (lower hand)
      while !stack.empty? && stack.last.last < node.value
        res[stack.pop.first] = node.value  
      end
      # iterate over list nodes and "raise a hand" (append to stack its [position & value])
      stack.append([res.count, node.value]) # [position index, node value]
      res.append(0)                         # placeholder, no higher values seen afterwards
      node = node.next
    end
    res
  end
end
 
list2 = LinkedList.new(2)
[1,5].each { |iteration| list2.append(iteration) }
resp = list2.next_larger_nodes
puts [resp, resp == [5,5,0]].inspect
# [[5, 5, 0], true]

list1 = LinkedList.new(2)
[7,4,3,5].each { |iteration| list1.append(iteration) }
resp = list1.next_larger_nodes
puts [resp, resp == [7,0,5,5,0]].inspect
# [[7, 0, 5, 5, 0], true]
