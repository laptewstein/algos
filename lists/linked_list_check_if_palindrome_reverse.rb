# reverse midway
class Node
  attr_accessor :data, :next
  def initialize(data, tail = nil)
    @data = data
    @next = tail
  end

  def is_palindrome?
    show
    previous = fast = slow = self
    return false unless self.next

    # determine middle node
    while fast && fast.next
      fast     = fast.next.next
      previous = slow
      slow     = slow.next
    end
    # odd sized list: skip over middle node
    slow = slow.next if fast # fast is NIL for even sized lists

    # terminate first half
    previous.next = nil
    # reverse the second half and compare
    compare Node.reverse slow
  end

  def self.reverse(head)
    current  = head
    previous = nil
    while current
      nxt          = current.next
      current.next = previous
      previous     = current
      current      = nxt
    end
    previous
  end

  def compare(other_head)
    show self
    show other_head
    l, r = self, other_head
    while l && r
      return false unless l.data == r.data
      l = l.next
      r = r.next
    end  
    true
  end

  def show(head = nil)
    current = head || self
    while current
      printf current.data.inspect
      current = current.next
      printf "->" if current
      STDOUT.flush
    end
    puts "\r"
  end
end

values  = [1,2,3,4,5,6,7,8,9,8,7,6,5,4,3,2,1]
idx     = 1
head    = Node.new(values.first)
current = head
while idx < values.size
  current.next = Node.new(values[idx])
  current = current.next
  idx = idx.succ
end

puts head.is_palindrome?
# 1->2->3->4->5->6->7->8->9->8->7->6->5->4->3->2->1
# 1->2->3->4->5->6->7->8
# 1->2->3->4->5->6->7->8
# true

head.next.next = Node.new(999, head.next.next);  nil
head.next.next.next.next.next = Node.new(888, head.next.next.next.next.next); nil
puts head.is_palindrome?
# 1->2->999->3->4->888->5->6->7->8
# 1->2->999->3->4
# 8->7->6->5->888
# false


