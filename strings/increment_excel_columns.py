"""
Given sequennce of characters, return next in alphabetic order.
Space is ignored (discarded); otherwise result of 'Z ZZ' should be defined ('A AAA' or 'AA AA'), which is right?
"""

import string
def increment_excel(s=''):
    """
    A->B, Z->AA, AZ->BA, KZZ->LAA
    """
    def wrapped(s):
        if not s: 
            return string.uppercase[0]
        ind = string.uppercase.index(s[-1])
        if ind < len(string.uppercase) - 1: 
            return s[:-1] + string.uppercase[ind + 1]
        return wrapped(s[:-1]) + string.uppercase[0]
    return wrapped(s.upper().replace(' ',''))


increment_excel('TRYME') # -> 'TRYMF'
increment_excel('TRY ZZ') # -> 'TRZAA'
increment_excel('ABCC') # -> 'ABCD'
increment_excel('ZZ Z') # -> 'AAAA'
