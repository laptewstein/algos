 #! /usr/bin/env python3
 # -*- coding: utf-8 -*-
import itertools

"""
Given a string of opening and closing parentheses, check whether it’s balanced.
"""

def chunk_slicer(iterable, repeat=2):
    """
    Given an iterable, slice it by 2 elements a time
    (as opposed to forloop which chops by one at a time).

    Example usage:
      - chunker('ABCDEFG', 3) -> [('A', 'B', 'C'), ('D', 'E', 'F'), ('G', None, None)]
      - chunker('ABCDEFGH', 2) -> [('A', 'B'), ('C', 'D'), ('E', 'F'), ('G', 'H')]
    """
    args = [iter(iterable)] * repeat
    return itertools.zip_longest(*args)


# Solution 1: O(n)
def is_balanced(collection: str, extension: str='') -> bool:
    """
    At least three types of parentheses allowed:
        - round brackets: (),
        - square brackets: [],
        - curly brackets: {}

    Assume that the string does not contain any other character, no spaces, words, or numbers.
    Balanced parentheses require every opening parenthesis to be closed in the reverse order opened.
    For example, `([{}{}()])` is balanced but `([)]` is not.

    Besides required string to evaluate,
    extension may be given to extend standard set of parentheses i.e. `<>` or `¿?¡!`.
    Both arguments must be balanced on order to pass the test.
    """
    precheck = [len(expr) % 2 for expr in (collection, extension)]
    if any([not len(collection)] + precheck):
        print(collection, extension)
        return False

    pairs = {('(', ')'),
             ('[', ']'),
             ('{', '}')}.union(chunk_slicer(extension))
    lefts = str.join('', (tpl[0] for tpl in pairs))
    stack = []

    for current in collection:
        if current in lefts: stack.append(current)
        else:
            if len(stack) == 0: return False
            last_seen = stack.pop()
            if (last_seen, current) not in pairs: return False

    return len(stack) == 0 # balanced if stack is empty


# Solution 2: O(n): recursive
def is_balanced_recursive(collection, pointer=0, count=0):
    """
    Find if the string given is balanced.
    Ignore any other character except `()`

    For each opening parentheses, increment `counter += 1`
    For each closing parentheses, decrement `count -= 1`.
    If counter goes to below 0 -> original string is not balanced
        - (closing parentheses was met before opening)
    If pointer advanced past last character and counter is positive -> original is not balanced
        - (many opening but not closings)
    """
    if pointer == len(collection):
        return count == 0
    if count < 0:
        return False

    if collection[pointer] == "(":
        return is_balanced_recursive(collection, pointer + 1, count + 1)
    elif collection[pointer] == ")":
        return is_balanced_recursive(collection, pointer + 1, count - 1)
    return is_balanced_recursive(collection, pointer + 1, count)


##### FLIGHT
if __name__ == '__main__':

    case_base = '{}()[]'
    case_one = ')('
    case_two = '{}{}[{}]()()(({}))'
    case_three = '{}{}[<{¡!}>]([()])()(({¿¿??}))'
    case_four = '{}{}[<{}>]()()¡!(({¿¿??}))¡¡'

    case_recursive_one = '((P)(A)(S)(S))((!!!))'
    case_recursive_two = '(F)((A)(I)))(L)(...)'

    print('%s: %s' % (case_base, is_balanced(case_base)))
    print('%s: %s' % (case_one, is_balanced(case_one)))
    print('%s: %s' % (case_two, is_balanced(case_two)))
    print('%s: %s' % (case_three, is_balanced(case_three, extension='<>¿?¡!')))
    print('%s: %s' % (case_four, is_balanced(case_four, extension='<>¿?¡!')))
    # {}()[]: True
    # )(: False                                 # obviously not balanced
    # {}{}[{}]()()(({})): True
    # {}{}[<{¡!}>]([()])()(({¿¿??})): True
    # {}{}[<{}>]()()¡!(({¿¿??}))¡¡: False       # ending exclamation marks not closed

    print('%s: %s' % (case_recursive_one, is_balanced_recursive(case_recursive_one)))
    print('%s: %s' % (case_recursive_two, is_balanced_recursive(case_recursive_two)))
    # ((P)(A)(S)(S))((!!!)): True
    # (F)((A)(I)))(L)(...): False               # extra closing parentheses after (I)