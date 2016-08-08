string="aaaaabbbbccccccaaaaaaa"


def recurse(string, previous, count=1):
    """
    Run-length encoding (RLE) is a very simple form of lossless data
    compression in which runs of data (that is, sequences in which
    the same data value occurs in many consecutive data elements)
    are stored as a single data value and count,
    rather than as the original run.

    Example: xxxxyycdd -> 4x2y1c2d
    """

    retval= ''
    if len(string) == 1:

        # last item, increase count and head to exit
        retval += '%s%s' % (
            count + 1,
            previous)
    else:
        if string[0] == previous:

            # Same char as previous.
            # increase count and recurse, chipping off leftmost one.
            retval = recurse(
                string[1:],
                string[0],
                count + 1)

        else:
            
            # Char is different from previous. 
            # Append previous char to a count and 
            # recurse with count 1 for the current char
            retval = '%s%s%s' % (
                count,
                previous,
                recurse(
                    string[1:],
                    string[0]))
    return retval


if len(string) == 1: 
    rle = '1%s' % string
else:
    rle = recurse(
        string=string[1:],
        previous=string[0])

print "Original: %s, encoded: %s" % (string, rle)
