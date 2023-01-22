# https://leetcode.com/problems/add-two-numbers/description/

# You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.
# You may assume the two numbers do not contain any leading zero, except the number 0 itself.

# Input: l1 = [2,4,3], l2 = [5,6,4]
# Output: [7,0,8]
# Explanation: 342 + 465 = 807.

# the trick to remember here is that we are iterating over reversed representation of an integer

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
        local_sum = local_sum / 10              # serves as a carryover
        tail      = tail.next                   # reassign running pointer to the newly created node
    end
    pointer_to_head.next
end



# Input: l1 = [7,5,9,4,6], l2 = [8,4]
# Output: [7,6,0,3,0]
# Explanation: 75946 + 84 = 76030
def add_two_arrays_representing_integers(l, r)
    res      = []
    overflow = 0
    idx_l, idx_r = l.size.pred, r.size.pred
    until idx_l == -1 && idx_r == -1 && overflow == 0
        sum = overflow
        if idx_l > -1
            sum += l[idx_l]
            idx_l -= 1
        end
        if idx_r > -1
            sum += r[idx_r]
            idx_r -= 1
        end
        res << sum % 10             # res.unshift sum % 10
        overflow = sum / 10
    end
    res.size.pred.step(0, -1).map { |s| res[s] }
end
puts add_two_arrays_representing_integers([7, 5, 9, 4, 6], [8, 4]).inspect