"""
Given an array of integers, find the smallest and second smallest element.
"""

import sys
import random
import operator
from typing import List, Tuple, Union


def second_smallest(lst: List[int]) -> Tuple[List, int, int]:

    # There should be at least two elements
    arr_len = len(lst)
    if operator.lt(arr_len, 2):
        print("Invalid Input")
        return None

    first = second = sys.maxsize
    for i in range(0, arr_len):

        # If current element is smaller than first then
        # update both first and second
        if operator.lt(lst[i], first):
            second = first
            first = lst[i]

        # If arr[i] is in between first and second then
        # update second
        elif operator.lt(lst[i], second) and operator.ne(lst[i], first):
            second = lst[i]

    if operator.eq(second, sys.maxsize):
        print("No second smallest element")
    return lst, first, second


##### FLIGHT
if __name__ == '__main__':
    if __import__('sys').version_info.major < 3:
        print('Tested with Python 3.5')

    line = 'Given list is %s: smallest: %d, second smallest (next higher): %d'
    list_generator = lambda: (random.randrange(-5, 50) for n in range(15))
    for l in (list_generator for _ in range(10)):
        list_ = list(l())
        print(line % second_smallest(list_))
