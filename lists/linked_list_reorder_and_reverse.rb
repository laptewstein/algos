# https://leetcode.com/problems/reorder-list

# add-on pack
class LinkedList
  # Given the head of a singly linked-list, reorder the list to be on the following form
  # L0 → L1 → … → Ln - 1 → Ln
  # L0 → Ln → L1 → Ln - 1 → L2 → Ln - 2 → …
  def reorder_list(head = nil)
    node = head || @head

    # iterate to miiddle, thisa is the new tail
    slow, fast = node, node.next
    while fast && fast.next
      slow = slow.next
      fast = fast.next.next
    end
    tail = slow
    # puts "new tail: #{tail}"

    # reverse the second half of the list
    current  = tail.next
    previous = tail.next = nil
    while current
      # NcnCNpPcCn
      nxt          = current.next # N  = cn
      current.next = previous     # CN = p
      previous     = current      # P  = c
      current      = nxt          # C  = n
    end
    reverse_head = previous

    # merge them back into one, sequentially
    node          = head || @head
    node_reversed = reverse_head
    while node && node_reversed
      orig_nxt      = node.next
      rev_nxt       = node_reversed.next

      node.next     = node_reversed
      node_reversed.next = orig_nxt

      node          = orig_nxt
      node_reversed = rev_nxt
    end
    head || @head
  end
  alias :reorder :reorder_list

  def reverse
    previous, current = nil, @head
    while current
      # NcnCNpPcCn
      nxt          = current.next # N  = cn
      current.next = previous     # CN = p
      previous     = current      # P  = c
      current      = nxt          # C  = n
    end
    @head = previous
  end
end

# testing dedup and uniq methods
list = LinkedList.new(0)
(1..20).each { |iteration| list.append(iteration) }

list.inspect
# list of ODD number of elements (21)
# 0->1->2->3->4->5->6->7->8->9->10->11->12->13->14->15->16->17->18->19->20

list.reverse
list.inspect
# 20->19->18->17->16->15->14->13->12->11->10->9->8->7->6->5->4->3->2->1->0

list.reverse
list.inspect
# 0->1->2->3->4->5->6->7->8->9->10->11->12->13->14->15->16->17->18->19->20

list.reorder
list.inspect
# 0->20->1->19->2->18->3->17->4->16->5->15->6->14->7->13->8->12->9->11->10

# list of EVEN number of elements (20)
# 0->1->2->3->4->5->6->7->8->9->10->11->12->13->14->15->16->17->18->19
# reverse: 19->18->17->16->15->14->13->12->11->10->9->8->7->6->5->4->3->2->1->0
# reorder: 0->19->1->18->2->17->3->16->4->15->5->14->6->13->7->12->8->11->9->10
