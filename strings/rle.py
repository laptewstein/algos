string="aaaaabbbbccccccaaaaaaa"


def recurse(string, initial, count):
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
    
        retval += '%s%s' % (
            count+1, 
            initial)

    else:    

        if string[0] == initial:
        
            retval = recurse(
                string[1:], 
                initial, 
                count+1)

        else:
        
            retval = '%s%s%s' % (
                count, 
                initial, 
                recurse(
                    string[1:], 
                    string[0], 
                    1))
    
    return retval

                
print "Original: %s, encoded: %s" % (string, recurse(
        string=string[1:],
        initial=string[0],
        count=1))

