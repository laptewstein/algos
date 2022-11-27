# https://leetcode.com/problems/remove-nth-node-from-end-of-list
# Given the head of a linked list, remove the nth node from the end of the list and return its head.

def remove_nth_from_end(head, n)
    # introducing an extra node in the beginning
    head_pointer = ListNode.new(nil, head)
    left  = head_pointer
    right = head_pointer.next # head

    while n > 0 && right
      right = right.next
      n     = n.pred
    end

    # traverse to the end of the list 
    # while maintaining the distance between pointers (window)
    while right
      left, right = left.next, right.next
    end

    left.next = left.next.next
    head_pointer.next
end
