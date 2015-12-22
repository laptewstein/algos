import sys
import collections
from typing import List
import random
"""
Given array of integers and same array minus one element, find which is missing in the second array.
"""

# Solution 1: O(N lon N)
def find_mssing_element_ineffective(lst_full: List[int], lst_trimmed: List[int]):
    """
    Inefficient solution is to sort the lists,
    and checking whether an element in the left array appears in the right too,

    Once two iterators have different values we can stop.
    The value of the first iterator is the missing element. This solution is also O(NlogN).
    """

    lst_full.sort()
    lst_trimmed.sort()
    for left, right in zip(lst_full, lst_trimmed):
        if left != right:
            return left # found missing
    return lst_full[-1]


# Solution 2: O(N)
def find_mssing_element_mapping(lst_full: List[int], lst_trimmed: List[int]):
    """
    Don't sort.
    Store the number of times an element appears in lst_trimmed - in a defaultdict.
    Then, for each element in the lst_full decrement element's counter.
    Once an element with zero count approached - that’s the missing element
    (0 means it's already decremented (case of repeated) or wasn't seen (unique)).
    """
    mapping = collections.defaultdict(int)
    for elem in lst_trimmed:
        mapping[elem] += 1
    for elem in lst_full:
        if mapping[elem] == 0:
            return elem
        else:
            mapping[elem] -= 1


# Solution 3: O(1) / XOR
def find_mssing_element_XOR(lst_full: List[int], lst_trimmed: List[int]):
    """
    XOR all the numbers in lst_full and lst_trimmed.
    All numbers in lst_trimmed also appear in lst_full, but there is an extra number
    in lst_full. So the effect of each XOR from lst_trimmed is being reset by the
    corresponding same number in lst_full (the order of XOR is not important).

    XOR Truth Table
    ---------------  What happens when we XOR two numbers?
    | L | R | XOR |  If we XOR <a number> two times with <some number>, nothing will change.
    ---------------  We can also XOR with multiple numbers and the order would not matter.
    | 0 | 0 |  0  |  For example: XOR any number N with N2, then XOR the result with N3,
    | 0 | 1 |  1  |  then XOR their result with N2, and then with N3. Twice N2 and twice N3.
    | 1 | 0 |  1  |  The final result would be the original number N1.
    | 1 | 1 |  0  |  That's because every XOR operation flips some bits and if XORred with the same
    ---------------  number again, we flip those bits back. The order of XOR operations is not important.

    The space complexity of this solution is constant O(1) since we only use one extra variable.
    Time complexity is O(N) because we perform a single pass from the arrays.
    """
    result = 0
    for num in lst_full + lst_trimmed:
        result ^= num
    return result


# Extra O(n):
# add element from left sequence and substract element from right sequence. Rinse, repeat.
# Overflow is possible with big numbers if summing up and subtracting whole arrays.
# But, if we keep adding/substracting one by one till we have negative number, it may work.
# then, any max number will still be inline with max integer limits. it adds complexity.


##### FLIGHT
if __name__ == '__main__':
    if __import__('sys').version_info.major < 3:
        print('Tested with Python 3.5')
    vf = '*v'

    # Test Case I -------------------------------------------------------------------------
    lst = [random.randint(0, sys.maxsize) for el in range(16)]
    missf, lst_ = lst[0], lst[1:]
    random.shuffle(lst_)
    tcf = lst, lst_

    print('\n-***- Test case 2: missing number = \t%s' % missf)
    tcf_ineff = find_mssing_element_ineffective(*tcf)
    tcf_map = find_mssing_element_mapping(*tcf)
    tcf_xor = find_mssing_element_XOR(*tcf)
    print('find_mssing_element_ineffective: \t[%s] %s' % (vf[tcf_ineff == missf], tcf_ineff))
    print('find_mssing_element_mapping: \t\t[%s] %s' % (vf[tcf_map == missf], tcf_map))
    print('find_mssing_element_XOR: \t\t\t[%s] %s' % (vf[tcf_xor == missf], tcf_xor))
    # -------------------------------------------------------------------------------------

    # Test Case II ------------------------------------------------------------------------
    lst = [random.randint(-sys.maxsize, 0) for el in range(16)]
    missm, lst_ = lst[0], lst[1:]
    random.shuffle(lst_)
    tcm = lst, lst_

    print('\n-***- Test case 2: missing number = \t%s' % missm)
    tcm_ineff = find_mssing_element_ineffective(*tcm)
    tcm_map = find_mssing_element_mapping(*tcm)
    tcm_xor = find_mssing_element_XOR(*tcm)
    print('find_mssing_element_ineffective: \t[%s] %s' % (vf[tcm_ineff == missm], tcm_ineff))
    print('find_mssing_element_mapping: \t\t[%s] %s' % (vf[tcm_map == missm], tcm_map))
    print('find_mssing_element_XOR: \t\t\t[%s] %s' % (vf[tcm_xor == missm], tcm_xor))
    # -------------------------------------------------------------------------------------

    # Test Case III -----------------------------------------------------------------------
    lst = [random.randint(-sys.maxsize >> 32, sys.maxsize >> 32) for el in range(16)]
    missl, lst_ = lst[0], lst[1:]
    random.shuffle(lst_)
    tcl = lst, lst_

    print('\n-***- Test case 3: missing number = \t%s' % missl)
    tcl_ineff = find_mssing_element_ineffective(*tcl)
    tcl_map = find_mssing_element_mapping(*tcl)
    tcl_xor = find_mssing_element_XOR(*tcl)
    print('find_mssing_element_ineffective: \t[%s] %s' % (vf[tcl_ineff == missl], tcl_ineff))
    print('find_mssing_element_mapping: \t\t[%s] %s' % (vf[tcl_map == missl], tcl_map))
    print('find_mssing_element_XOR: \t\t\t[%s] %s' % (vf[tcl_xor == missl], tcl_xor))
    # -------------------------------------------------------------------------------------

# -***- Test case 2: missing number = 	6478330289347169727
# find_mssing_element_ineffective: 	[v] 6478330289347169727
# find_mssing_element_mapping: 		[v] 6478330289347169727
# find_mssing_element_XOR: 			[v] 6478330289347169727
#
# -***- Test case 2: missing number = 	-5682910616121461240
# find_mssing_element_ineffective: 	[v] -5682910616121461240
# find_mssing_element_mapping: 		[v] -5682910616121461240
# find_mssing_element_XOR: 			[v] -5682910616121461240
#
# -***- Test case 3: missing number = 	-60748666
# find_mssing_element_ineffective: 	[v] -60748666
# find_mssing_element_mapping: 		[v] -60748666
# find_mssing_element_XOR: 			[v] -60748666