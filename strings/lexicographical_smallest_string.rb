def lexicographically_smallest(string, n)
  result = ''
  until string.empty?
    puts [string, result].inspect
    n_chars = string[0...n].chars.sort
    result += n_chars[0]
    str = n_chars[1..-1].join
    str += string[n..-1] if string[n..-1]
    string = str
  end  
  result
end

# same as below, without sorting and splitting
def lexicographically_smallest(string, n)
  result = ''
  until string.empty?
    puts [string, result].inspect
    idx = 0
    smallest = string[idx]
    (idx.succ...[n, string.length].min).each do |i|
      next if string[i] > smallest
      smallest = string[i]
      idx = i
    end
    result += smallest

    str = string[0...idx]
    str += string[idx.succ..-1] if string[idx.succ..-1]
    string = str
  end
  result
end

# puts lexicographically_smallest('gaurang', 3) == 'agangru'
# true
# ["gaurang", ""]
# ["gurang", "a"]
# ["ruang", "ag"]
# ["rung", "aga"]
# ["rug", "agan"]
# ["ru", "agang"]
# ["u", "agangr"]

puts lexicographically_smallest('geeksforgeeks', 5) == 'eefggeekkorss'
true
# ["geeksforgeeks", ""]
# ["egksforgeeks", "e"]
# ["fgksorgeeks", "ee"]
# ["gkosrgeeks", "eef"]
# ["korsgeeks", "eefg"]
# ["korseeks", "eefgg"]
# ["korseks", "eefgge"]
# ["korsks", "eefggee"]
# ["korss", "eefggeek"]
# ["orss", "eefggeekk"]
# ["rss", "eefggeekko"]
# ["ss", "eefggeekkor"]
# ["s", "eefggeekkors"]




# You are given a string of length N and a parameter k. The string can be manipulated by taking one of the first k letters and moving it to the end.

# Write a program to determine the lexicographically smallest string that can be created after an unlimited number of moves.

# For example, suppose we are given the string daily and k = 1. The best we can create in this case is ailyd.