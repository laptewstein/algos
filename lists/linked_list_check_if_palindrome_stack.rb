# using stack
class Node
  attr_accessor :data, :next
  def initialize(data, tail = nil)
    @data = data
    @next = tail
  end

  def is_palindrome?
    current = self
    stack   = []
    while current
      stack << current.data
      current = current.next
    end
    current = self
    while current
       return false unless current.data == stack.pop
       current = current.next
    end
    true
  end
end

values  = [1,2,3,4,3,2,1]
idx     = 1
head    = Node.new(values.first)
current = head
while idx < values.size
  current.next = Node.new(values[idx])
  current = current.next
  idx = idx.succ
end

puts head.is_palindrome? # true
head.next.next = Node.new(999, head.next.next)
puts head.is_palindrome? # false

