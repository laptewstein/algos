"""
Given sequennce of characters, return next in alphabetic order.
Space is ignored (discarded); otherwise result of 'Z ZZ' should be defined ('A AAA' or 'AA AA'), which is right?
"""
import string
def increment_excel(s=''):
    '''
    A->B, Z->AA, AZ->BA, KZZ->LAA
    '''
    def wrapped(s):
        if not s: 
            return string.uppercase[0]
        ind = string.uppercase.index(s[-1])
        if ind < len(string.uppercase) - 1: 
            return s[:-1] + string.uppercase[ind + 1]
        return wrapped(s[:-1]) + string.uppercase[0]
    return wrapped(s.upper().replace(' ',''))




def seqconverter(a):
    def converter(number):
        retval = str()
        while number:
            x = (number - 1) % 26
            number = (number - 1) / 26
            retval = '%s%s' % (chr(x + 65), retval)
        return retval

    def numconverter(a):
        res = 0
        for c in a:
            res *= 26
            res += ord(c) - 64
        return res
    return converter(numconverter(a) + 1)



seqconverter('ZYZ')     # -> 'ZZA'
seqconverter('ZZA')     # -> 'ZZB'
seqconverter('XY')      # -> 'XZ'

seqconverter('TRYME')   # -> 'TRYMF'
seqconverter('TRYZZ')   # -> 'TRZAA'
seqconverter('ABCC')    # -> 'ABCD'
seqconverter('ZZZ')     # -> 'AAAA'
