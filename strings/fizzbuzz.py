"""
Write a program that prints the numbers,
for multiples of three print "Fizz"
and for the multiples of five print "Buzz".
For numbers which are multiples of both, print "FizzBuzz"
"""


def fb(n, prefix=''):
    """
    Oneliner:
        print("Fizz"*(not n % 3) + "Buzz"*(not n % 5) or n)
    """
    _3, _5 = (n % i for i in (3,5))
    if not _3: prefix += 'Fizz'
    if not _5: prefix += 'Buzz'
    print (prefix or n)