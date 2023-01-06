def create_pyramid(height, char = '*', leading_spaces = nil)
  line_no        = 1
  leading_spaces ||= height
  char_count     = 1
  until height == 0
    print("%2d" % line_no)
    print(' ' * leading_spaces)
    print(char * char_count)
    print(" #{leading_spaces}")
    print("\n")
    leading_spaces -= 1 # each line consumes one leading space
    char_count     += 2 # chars expand from both sides
    line_no        += 1
    height         -= 1
  end
end

create_pyramid(15)
#  1               * 15
#  2              *** 14
#  3             ***** 13
#  4            ******* 12
#  5           ********* 11
#  6          *********** 10
#  7         ************* 9
#  8        *************** 8
#  9       ***************** 7
# 10      ******************* 6
# 11     ********************* 5
# 12    *********************** 4
# 13   ************************* 3
# 14  *************************** 2
# 15 ***************************** 1

def create_pyramid_with_inner_triangle(height, char = '*', leading_spaces = nil)
  line_no        = 1
  inner_triagle  = height / 2
  inner_triagle_char_count = height - 1
  if height.odd?
    inner_triagle += 1 
    inner_triagle_char_count -= 1
  end
  leading_spaces ||= height + 4
  char_count     = 1
  until height == 0
    print("%2d" % line_no)
    print(' ' * leading_spaces)
    if line_no > inner_triagle
      side = char_count - inner_triagle_char_count 
      print(char * (side / 2)) 
      print(' ' * inner_triagle_char_count)
      print(char * (side / 2))
      inner_triagle_char_count -= 2
    else
      print(char * char_count)
    end
    print("\n")
    leading_spaces -= 1 # each line consumes one leading space
    char_count     += 2 # chars expand from both sides
    line_no        += 1
    height         -= 1
  end
end

create_pyramid_with_inner_triangle(3)
puts '-' * 20
create_pyramid_with_inner_triangle(16)
puts '-' * 44
create_pyramid_with_inner_triangle(30)
puts '-' * 70

#  1       *
#  2      ***
#  3     ** **
# --------------------
#  1                    *
#  2                   ***
#  3                  *****
#  4                 *******
#  5                *********
#  6               ***********
#  7              *************
#  8             ***************
#  9            *               *
# 10           ***             ***
# 11          *****           *****
# 12         *******         *******
# 13        *********       *********
# 14       ***********     ***********
# 15      *************   *************
# 16     *************** ***************
# --------------------------------------------
#  1                                  *
#  2                                 ***
#  3                                *****
#  4                               *******
#  5                              *********
#  6                             ***********
#  7                            *************
#  8                           ***************
#  9                          *****************
# 10                         *******************
# 11                        *********************
# 12                       ***********************
# 13                      *************************
# 14                     ***************************
# 15                    *****************************
# 16                   *                             *
# 17                  ***                           ***
# 18                 *****                         *****
# 19                *******                       *******
# 20               *********                     *********
# 21              ***********                   ***********
# 22             *************                 *************
# 23            ***************               ***************
# 24           *****************             *****************
# 25          *******************           *******************
# 26         *********************         *********************
# 27        ***********************       ***********************
# 28       *************************     *************************
# 29      ***************************   ***************************
# 30     ***************************** *****************************
# ----------------------------------------------------------------------

