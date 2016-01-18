# Generate all permutations of a given string.

def permutations_logic(charset):
    """
    Let the string be ‘CES’, and we have length 2 permutations ‘ES’ and ‘SE’.
    How do we incorporate the letter C into these permutations?
    We just insert it into every possible location in both strings:
    beginning, middle, and the end. So for ‘SE’ the result is: ‘CSE’,
    ‘SCE’, ‘SEC’. And for the string ‘ES’ the results is: ‘CES’, ‘ECS’, ‘ESC’.

    Recurse until the string is of length 1 by repeatedly removing the
    first character, this is the base case and the result is the string itself
    (the permutation of a string with length 1 is itself).

    Then apply the above algorithm, at each step insert the
    character removed to every possible location in the
    recursion results; then return results to layer above.

    We remove the first character and recurse to get all
    permutations of length N-1, then we insert that first
    character into N-1 length strings and obtain all
    permutations of length N.

    The complexity is O(N!) because there are N! possible
    permutations of a string with length N, so it’s optimal.

    It's not advised to try it on strings longer
    than 10-12 characters though, as it will take a long time to complete.
    Inherently, there are just too many permutations.
    """
    fingerize = permutations_logic  # declarative visualized renaming
    if len(charset) < 2:
        # start from last char
        if DEBUG: print('Last letter is \'%(c)s\', starting FiveFingerFillet '
                        '(\'FFF\' game) with [\'%(c)s\']' % {'c': charset})
        return [charset]

    # we will use knife game terminology, with first letter of the word and the rest
    stab, palm = charset[:1], charset[1:]

    # recurse over rest of the word until single char left
    fingers = fingerize(palm)
    round_response = list()

    if DEBUG:
        args = charset, stab, fingers
        print('**** (This round charset: %s) stab: %s, fingers: %s' % args)

    #iterate over all permutations of length N-1
    for fingaz in fingers:

        if DEBUG:
            r_ = 'Response so far: %s' % round_response
            args = stab, fingaz, len(fingaz), r_
            print('#### Permute round: %s + %s* (%d fingers) %s' % args)

        #insert the character into every possible location
        for position in range(len(fingaz) + 1):

            chopping_attempt = fingaz[:position] + stab + fingaz[position:]

            if DEBUG:
                args = (round_response, chopping_attempt,
                        fingaz[:position] or EMPTY, stab, fingaz[position:] or EMPTY)
                print('%s + [\'%s\'] by (%s + %s + %s)' % args)

            round_response.append(chopping_attempt)

    if DEBUG: print('Returning %s' % round_response)
    return round_response


# clean version
def permutations(charset=''):
    """
    Generate all permutations of a given string.
    """
    if len(charset) < 2: return [charset]
    perms = permutations(charset[1:])
    key, res = charset[0], []
    for perm in perms:
        for pos in range(len(perm) + 1):
            res.append(perm[:pos] + key + perm[pos:])
    return res


##### FLIGHT
if __name__ == '__main__':
    if __import__('sys').version_info.major < 3:
        print('Tested with Python 3.5')

    DEBUG = True  # if False, same result as if `permutations` was called
    EMPTY = '...'
    TEST_CASE_SEPARATOR = '-', '=', 80

    WORDS = '.', 'AK', 'HSO', 'TRAK'
    CALCULATIONS = (['.'], ['AK', 'KA'], ['HSO', 'SHO', 'SOH', 'HOS', 'OHS', 'OSH'],
        ['TRAK', 'RTAK', 'RATK', 'RAKT', 'TARK', 'ATRK', 'ARTK', 'ARKT',
         'TAKR', 'ATKR', 'AKTR', 'AKRT', 'TRKA', 'RTKA', 'RKTA', 'RKAT',
         'TKRA', 'KTRA', 'KRTA', 'KRAT', 'TKAR', 'KTAR', 'KATR', 'KART'])

    for w, validation in zip(WORDS, CALCULATIONS):
        print('%s' % ('%s ' % w).ljust(TEST_CASE_SEPARATOR[2], TEST_CASE_SEPARATOR[0]))
        perms = permutations_logic(w)
        assert perms == validation, 'Test case failed.'
        args = (w, len(perms), '' if len(perms) < 2 else 's',
                perms, TEST_CASE_SEPARATOR[1] * TEST_CASE_SEPARATOR[2])
        print('\'%s\' implies %d permutation%s -> %s\n%s\n' % args)