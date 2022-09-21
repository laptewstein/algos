"""
Find a pair of elements from an array whose sum equals to a given number.
    No pair should use the same elements more than once.

    O(N^2)
    For each element checking whether (target-element) is present in
    the array, This is of course far from optimal.
"""

# Solution 1
def pairsum(lst, target, print_matches=False):
    """
    O(NlogN) (due to sorting)
    A more efficient solution would be to sort the array and having two pointers
    to scan the array from the beginning and the end at the same time.
    If the sum of the values in left and right pointers equals to target, we
    output the pair.

    If the sum is less than target:
        advance the left pointer,
    If the current is greater than target:
        decrement the right pointer,
    until both pointers meet at some part of the array.
    """
    output = []
    lst = lst[:]
    if len(lst) < 2: return output
    lst.sort() 
    left_pointer, right_pointer = (0, len(lst)-1)

    while left_pointer < right_pointer:
        current = lst[left_pointer] + lst[right_pointer]

        if current == target:

            output.append([lst[left_pointer], lst[right_pointer]])
            if print_matches:
                print('%s + %s = %s' % (lst[left_pointer], lst[right_pointer], target))

            # moving on: rendering found pair unreachable
            left_pointer += 1
            right_pointer -= 1

        elif current < target:
            # sum is less than expected, try next higher from left
            left_pointer += 1
        else:
            # sum is more than expected, try next lower from right
            right_pointer -= 1
    return output


# Solution 2: mapping
def pairsum_mapping(lst, target, print_matches=False):
    """
    O(1), worst O(n) due to dictionary insertion/retrieval
    Without sorting the list, using intermediate mapping to
    hold `seen` values with required keys.
    """
    mapping = {}
    output = []
    for elem in lst:
        if elem in mapping:
            # won't appear more than once
            pair = [mapping.pop(elem), elem]
            output.append(pair)
            if print_matches:
                print('%s + %s = %s' % (*pair, target))
        else:
            mapping[target - elem] = elem
    return output


# Solution 2.5: set
def pairsum_set(lst, target, print_matches=False):
    """
    O(1), worst O(n) due to set removal
    Without sorting the list, using intermediate set to
    hold `seen` values.
    """
    if len(lst) < 2: 
        return 
    seen = set() 
    output = []
    for elem in lst:
        required = target - elem
        if required in seen:
            # won't appear more than once
            seen.discard(required)
            # [min(elem, required), max(elem, required)]
            pair = [required, elem]
            output.append(pair)
            if print_matches:
                print('%s + %s = %s' % (*pair, target))
        else:
            seen.add(elem)
    return output


##### FLIGHT
if __name__ == '__main__':
    lst_ = [3, 5, 95, 5, 95, 5, 6]
    lst_larger = [x for x in range(110)]
    lst_negatives = [x for x in range(-15, 32)]

    pointers_test_one   = pairsum(lst_, 100, True)
    pointers_test_two   = pairsum(lst_larger, 100)
    pointers_test_three = pairsum(lst_negatives, 27)

    mapping_test_one    = pairsum_mapping(lst_, 100)
    mapping_test_two    = pairsum_mapping(lst_larger, 100)
    mapping_test_three  = pairsum_mapping(lst_negatives, 27)

    set_test_one        = pairsum_set(lst_, 100)
    set_test_two        = pairsum_set(lst_larger, 100)
    set_test_three      = pairsum_set(lst_negatives, 27, True)

    assert pointers_test_one[::-1] == mapping_test_one == set_test_one
    assert pointers_test_two[::-1] == mapping_test_two == set_test_two
    assert pointers_test_three[::-1] == mapping_test_three == set_test_three

    print(pointers_test_one)
    print(pointers_test_two)
    print(pointers_test_three)

# 5 + 95 = 100
# 5 + 95 = 100

# 13 + 14 = 27
# 12 + 15 = 27
# 11 + 16 = 27
# 10 + 17 = 27
# 9 + 18 = 27
# 8 + 19 = 27
# 7 + 20 = 27
# 6 + 21 = 27
# 5 + 22 = 27
# 4 + 23 = 27
# 3 + 24 = 27
# 2 + 25 = 27
# 1 + 26 = 27
# 0 + 27 = 27
# -1 + 28 = 27
# -2 + 29 = 27
# -3 + 30 = 27
# -4 + 31 = 27

# [[5, 95], [5, 95]]

# [[0, 100], [1, 99], [2, 98], [3, 97], [4, 96], [5, 95], [6, 94], [7, 93], [8, 92], [9, 91], [10, 90], [11, 89], [12, 88], [13, 87], [14, 86], [15, 85], [16, 84], [17, 83], [18, 82], [19, 81], [20, 80], [21, 79], [22, 78], [23, 77], [24, 76], [25, 75], [26, 74], [27, 73], [28, 72], [29, 71], [30, 70], [31, 69], [32, 68], [33, 67], [34, 66], [35, 65], [36, 64], [37, 63], [38, 62], [39, 61], [40, 60], [41, 59], [42, 58], [43, 57], [44, 56], [45, 55], [46, 54], [47, 53], [48, 52], [49, 51]]

# [[-4, 31], [-3, 30], [-2, 29], [-1, 28], [0, 27], [1, 26], [2, 25], [3, 24], [4, 23], [5, 22], [6, 21], [7, 20], [8, 19], [9, 18], [10, 17], [11, 16], [12, 15], [13, 14]]

# visualize Python
# https://cscircles.cemc.uwaterloo.ca/visualize


