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

    absolute_low = second_smallest = sys.maxsize
    for i in range(0, arr_len):

        # current element is lower than lowest?
        if lst[i] < absolute_low:

            # make (currently) lowest a second_smallest: we found lower
            second_smallest = absolute_low
            # then assign this all-time low as absolute
            absolute_low = lst[i]

        # current element in between absolute low and second-smallest?
        elif absolute_low < lst[i] < second_smallest:

            # update second_smallest
            second_smallest = lst[i]

    if operator.eq(second_smallest, sys.maxsize):
        print("No second smallest element")
    return lst, absolute_low, second_smallest


##### FLIGHT
if __name__ == '__main__':
    if __import__('sys').version_info.major < 3:
        print('Tested with Python 3.5')

    line = 'Given list is %s: smallest: %d, second smallest (next higher): %d'
    list_generator = lambda: (random.randrange(-5, 50) for n in range(15))
    for l in (list_generator for _ in range(10)):
        list_ = list(l())
        print(line % second_smallest(list_))
