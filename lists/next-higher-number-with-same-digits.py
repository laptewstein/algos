import operator
"""
Given a number, find the next higher number using only the digits in the given number.
"""

"""
The naive approach is to generate the numbers with all digit permutations
    and sort them, then find the given number in the sorted sequence and
    return the next number in sorted order as a result.
        The complexity of this approach is pretty high though, because of the
    permutation step involved: a given number N has logN+1 digits, so there are
    O(logN!) permutations.

    After generating the permutations, sorting them will require O(logN! log logN!)
    operations. We can simplify this further, remember that O(logN!) is equivalent
    to O(NlogN). And O(loglogN!) is O(logN). So, the complexity is O(N(logN)^2).
"""

# Solution: O(logN)
def next_higher(number):
    """
    Let’s visualize a solution using an example:
    given the number 12543, next higher number with same digits is 13245

     ██╗██████╗ ███████╗██╗  ██╗██████╗          ██╗██████╗ ██████╗ ██╗  ██╗███████╗
    ███║╚════██╗██╔════╝██║  ██║╚════██╗        ███║╚════██╗╚════██╗██║  ██║██╔════╝
    ╚██║ █████╔╝███████╗███████║ █████╔╝  -->   ╚██║ █████╔╝ █████╔╝███████║███████╗
     ██║██╔═══╝ ╚════██║╚════██║ ╚═══██╗         ██║ ╚═══██╗██╔═══╝ ╚════██║╚════██║
     ██║███████╗███████║     ██║██████╔╝         ██║██████╔╝███████╗     ██║███████║
     ╚═╝╚══════╝╚══════╝     ╚═╝╚═════╝          ╚═╝╚═════╝ ╚══════╝     ╚═╝╚══════╝

    1. Scan the digits of the given number starting from the tenths digit
        (which is 4 in case of 12543), going towards left.
    2. At each iteration we check the right digit of the current digit.
    3. If the value of right (3) is greater than current (4):
        - stop;
        - otherwise continue looking for the to left.
        3.1 Start with digit 4, right digit is 3; 4 >= 3; continue scanning.
        3.2 (Next left digit) is 5, (right digit) is 4; 5 >= 4; continue.
    4. Next current is 2, right is 5, but 2 < 5, stop scanning.
        4.1 The digit 2 is our pivot digit. From the digits to the right of 2 [`543`],
        we find THE SMALLEST DIGIT HIGHER THAN 2, which is 3.
    5. Swap this digit (3) and the pivot digit (2), so the number becomes 13542.
        - pivot digit is now 3 (same position in string of `13542` (new) vs `12543` (old))
    6. Sort all the digits to the right of the pivot digit (3) in increasing order,
        resulting in `13` + sorted[`5,4,2`] -> `13`+ [2,4,5] -> `13245`

    `-.__    Note: If the digits of a given number are decreasing from left to right,
         `--...__           like in 864421, this is already The Highest Number.
                 `\         There’s no higher number with those digits.
                   `-.      Return the given number itself.

    --*C*O*M*P*L*E*X*I*T*Y*--
    The complexity of this algorithm depends on:
        - the number of digits;
        - sorting part dominates.
        A given number N has logN+1 digits; in worst case: sort logN digits.
        Worst case:  digits are increasing from right to left except the leftmost digit (i.e 1862)
        For sorting we don’t have to use comparison based algorithms such as
            - quicksort,
            - mergesort, or
            - heapsort
        which are all O(KlogK), where K is the number of elements to sort. Since digits are 0..9,
        sorting them always implies linear time O(K) complexity with any algorithm:
            - counting sort,
            - radix sort, or
            - bucket sort
        Overall complexity of sorting logN digits will stay linear resulting in overall complexity
        O(logN). It is optimal, since we have to check each digit at least once.
    """

    str_representation = '%d' % number

    # - starting from tenths pointer, counting backwards to 0 (beginning of string)
    pointers = range(len(str_representation) - 2, -1, -1)

    for pointer in pointers:
        pivot = str_representation[pointer]
        right_digit = str_representation[pointer + 1]

        # string comparison
        if operator.ge(pivot, right_digit): continue

        pivot_right = sorted(str_representation[pointer:], reverse=True)

        # next higher from last duplicate of pivot
        last_current = pivot_right.index(pivot)

        next_ = pivot_right[last_current - 1]
        pivot_right.remove(next_)

        rest = ''.join(pivot_right[::-1])
        return int(str_representation[:pointer] + next_ + rest)

    return number


##### FLIGHT
if __name__ == '__main__':
    if __import__('sys').version_info.major < 3:
        print('Tested with Python 3.5')

    line = 'Given Number is %d, next higher is %d'
    for number in [12543, 1254322, 554563442, 523,646758, 78361767, 12345, 654321, 2342,]:
        res = number, next_higher(number)
        print(line % res)

    # Given Number is 12543, next higher is 13245
    # Given Number is 1254322, next higher is 1322245
    # Given Number is 554563442, next higher is 554564234
    # Given Number is 523, next higher is 532
    # Given Number is 646758, next higher is 646785
    # Given Number is 78361767, next higher is 78361776
    # Given Number is 12345, next higher is 12354
    # Given Number is 654321, next higher is 654321
    # Given Number is 2342, next higher is 2423