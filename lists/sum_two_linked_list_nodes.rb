# https://leetcode.com/problems/add-two-numbers/description/

# You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

# You may assume the two numbers do not contain any leading zero, except the number 0 itself.

# Input: l1 = [2,4,3], l2 = [5,6,4]
# Output: [7,0,8]
# Explanation: 342 + 465 = 807.

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
    pointer_to_head = ListNode.new # dummy
    tail            = pointer_to_head
    local_sum       = 0
    until l1.nil? && l2.nil? && local_sum == 0 # same as "while l1 || l2 || local_sum > 0"
        if l1
            local_sum += l1.val
            l1         = l1.next
        end
        if l2
            local_sum += l2.val
            l2         = l2.next
        end
        tail.next = ListNode.new local_sum % 10 # hook up
        local_sum = local_sum / 10 # serves as a carryover
        tail      = tail.next # reassign running pointer to the newly created node 
    end
    pointer_to_head.next
end


