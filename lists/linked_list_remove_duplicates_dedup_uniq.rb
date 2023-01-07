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
  end

  def append(value)
    tail.next = ListNode.new(value)
  end

  def tail
    node = @head
    while node.next
      node = node.next
    end
    node
  end

  def append_after(target, value)
    node      = find(target)
    return unless node
    node.next = ListNode.new(value, node.next)
  end

  def find(value)
    node = @head
    return node if node.value == value
    while node.next
      node = node.next
      return node if node.value == value
    end
    nil
  end

  def delete(value)
    if @head.value == value
      @head = @head.next
      return true
    end
    node      = find_before(value)
    node.next = node.next.next
  end

  def find_before(value)
    node = @head
    return false unless node.next
    return node if node.next.value == value
    while node.next
      node = node.next
      return node if node.next.value == value
    end
  end

  # reference by index, like in an array
  def [](index)
    node = @head
    index.times do |i|
      return unless node
      node = node.next
    end
    node
  end

  def inspect
    node = @head
    print("#{node}")
    while node.next
      node = node.next
      print("->#{node}")
    end
    print "\n"
  end

  # Remove duplicate values
  # 3->2->2->1->3->2->4
  # => 3->2->1->4
  def dedup
    require 'set'
    current = @head
    seen = Set.new([current.value])
    while current.next
      if seen.include?(current.next.value)
        current.next = current.next.next
      else
        seen << current.next.value
        current = current.next
      end
    end
    @head
  end

  # Remove non-unique nodes
  # 3->2->2->1->3->2->4
  # 1->4
  def uniq
    return unless @head

    current = @head
    seen    = Hash.new(0)
    seen[current.value] = 1
    # 1) analyze and remove duplicates
    while current.next
      seen[current.next.value] += 1
      if seen[current.next.value] == 1
        current = current.next
      else
        # duplicate: remove in place (first pass)
        # this step is optional as we remove duplicates with second pass
        current.next = current.next.next
      end
    end

    # 2) iterate over the chain again & reject items we've seen > than once
    dummy   = ListNode.new(nil, @head)
    current = dummy
    while current.next
      if seen[current.next.value] > 1
        # remove nodes with count exceeding 1
        current.next = current.next.next
      else
        current = current.next
      end
    end
    # 3) update self. important!
    # if this step is missed, we end up with stale nodes which shouldn't be there (head is one of them, it might not be present in the final list if it's not a unique value)
    @head = dummy.next
  end
end

# testing dedup and uniq methods
list = LinkedList.new(3)
list.append(2)
list.append(2)
list.append(1)
list.append(3)
list.append(2)
list.append(4)

list.inspect
list.dedup
list.inspect
# 3 -> 2 -> 2 -> 1 -> 3 -> 2 -> 4
# => 3 -> 2 -> 1 -> 4

puts '=' * 10
list = LinkedList.new(3)
list.append(2)
list.append(2)
list.append(1)
list.append(3)
list.append(2)
list.append(4)

list.inspect
list.uniq
list.inspect 
# 3->2->2->1->3->2->4
# => 1 -> 4
