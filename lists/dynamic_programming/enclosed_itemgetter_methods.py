# cons(a, b) constructs a pair,
# and car(pair) and cdr(pair) returns the first and last element of that pair.

# For example,
# car(cons(3, 4)) returns 3,
# and
# cdr(cons(3, 4)) returns 4.

# Given this implementation of cons:

def cons(a, b):
    def pair(f):
        return f(a, b)
    return pair

# >>>>> Implement car and cdr. <<<<<<

import operator
my_pair = cons(3, 4)

# one
def car(pair):
    return pair(lambda a, b: a)

# two
def cdr(pair):
    def func(*args):
        return operator.itemgetter(0)(args)
    return pair(func)

# =======
print(car(my_pair))
print(cdr(my_pair))

#
# three
def car(pair, index = 0):
    return pair(lambda *args: operator.itemgetter(index)(args))

def cdr(pair, index = -1):
    return pair(lambda *args: operator.itemgetter(index)(args))

# =======
print(car(my_pair))
print(cdr(my_pair))

#
# four
def get_anything(pair, index = 0):
    return pair(lambda *args: operator.itemgetter(index)(args))

# =======
print(get_anything(my_pair))
print(get_anything(my_pair, -1))