from typing import List
import random
"""
Given an array of integers (positive and negative), find the largest continuous sum.
"""


# Time complexity: O(N), space complexity: O(1)
def largest_continuous_sum(lst: List[int]) -> List[int]:
    """
    If the array is all positive, then the result is simply the sum of all numbers.
    The negative numbers in the array slightly complicate things.
    The algorithm is, we start summing up the numbers and store in a current sum
    variable. After adding each element, we check whether the current sum is larger
    than maximum sum encountered so far. If it is, we update the maximum sum.

    As long as the current sum is positive, we keep adding the numbers.
    When the current sum becomes negative, we start with a new current sum, because
    a negative current sum will only decrease the sum of a future sequence.

    Note that we don’t reset the current sum to 0; sublist can contain negative integers.
    """
    if not lst: return lst
    max_sum = current_streak = lst[0]
    for elem in lst[1:]:
        current_streak = max(current_streak + elem, elem)
        max_sum = max(current_streak, max_sum)
    return max_sum


def largest_continuous_sum_with_positions(lst: List[int]) -> List[int]:
    """
    With pointers of start and end for the sublist
    """
    if not lst: return lst
    max_sum = current = lst[0]
    start = tstart = end = 0
    for pointer in range(1, len(lst)):  # start from second
        if lst[pointer] > current + lst[pointer]:
            tstart = pointer
            current = lst[pointer]
        else:
            current += lst[pointer]
        if current > max_sum:
            max_sum = current
            start = tstart
            end = pointer
    return max_sum, start, end


def largest_continuous_non_negative_sum(lst: List[int]) -> List[int]:
    """
    Negative element resets current streak (accumulation stops).
    """
    max_sum = current_streak = 0
    for elem in lst:
        if elem < 0:  # showstopper
            current_streak = 0
        else:
            current_streak += elem
        max_sum = max(current_streak, max_sum)
    return max_sum


##### FLIGHT
if __name__ == '__main__':
    if __import__('sys').version_info.major < 3:
        print('Tested with Python 3.5')

    header = '\n%(s)s List: %%s,' \
             '\n%(s)s Length: %%s, Sum of all elements: %%s' % dict(s='**')
    vis_msg = '-------- Result of %s: %s'
    funcs = (largest_continuous_sum,
             largest_continuous_sum_with_positions,
             largest_continuous_non_negative_sum)

    lst = [random.randint(-20, 53) for el in range(16)]
    lst_ = [-40, 1, 40, -50, 1, 50, -20, 1, 20, 0, 0]
    lst__ = [5, -1, -2, 3, -2]

    # import itertools
    # for l, func in itertools.product(lists, funcs):
    #     print(header % (l, len(l), sum(l)))
    #     print(vis_msg % (func.__name__, func(l)))

    for l in (lst, lst_, lst__):
        print(header % (l, len(l), sum(l)))
        for func in funcs:
            print(vis_msg % (func.__name__, func(l)))


    # ** List: [-8, 11, -15, 19, -15, 22, 23, 32, 41, 5, 21, 1, -17, -10, -11, 14],
    # ** Length: 16, Sum of all elements: 113
    # -------- Result of largest_continuous_sum: 149
    # -------- Result of largest_continuous_sum_with_positions: (149, 3, 11)
    # -------- Result of largest_continuous_non_negative_sum: 145
    #
    # ** List: [-40, 1, 40, -50, 1, 50, -20, 1, 20, 0, 0],
    # ** Length: 11, Sum of all elements: 3
    # -------- Result of largest_continuous_sum: 52
    # -------- Result of largest_continuous_sum_with_positions: (52, 4, 8)
    # -------- Result of largest_continuous_non_negative_sum: 51
    #
    # ** List: [5, -1, -2, 3, -2],
    # ** Length: 5, Sum of all elements: 3
    # -------- Result of largest_continuous_sum: 5
    # -------- Result of largest_continuous_sum_with_positions: (5, 0, 0)
    # -------- Result of largest_continuous_non_negative_sum: 5