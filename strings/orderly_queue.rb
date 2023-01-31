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

puts lexicographically_smallest('gaurang', 3) == 'agangru' # true
# ["gaurang", ""]
# ["gurang", "a"]
# ["ruang", "ag"]
# ["rung", "aga"]
# ["rug", "agan"]
# ["ru", "agang"]
# ["u", "agangr"]

puts lexicographically_smallest('geeksforgeeks', 5) == 'eefggeekkorss' # true
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


# https://leetcode.com/problems/orderly-queue/description/
# You are given a string s and an integer k. 
# You can choose one of the first k letters of s and append it at the end of the string..
# Return the lexicographically smallest string you could have after applying the mentioned step any number of moves.

def orderly_queue(s, k)
  return s.chars.sort.join if k > 1
  min = s
  (0...s.length.pred).each do |idx|
    seq = "#{s[idx.succ..-1]}#{s[0..idx]}"
    puts seq
    min = seq if seq < min
  end
  min
end
puts orderly_queue('daily', 1) == 'ailyd' # true
# ["ailyd", "ilyda", "lydai", "ydail", "daily"]

puts orderly_queue('cba', 1) == 'acb'     # true
# ['bac','acb']
puts orderly_queue('baaca', 3) == 'aaabc' # true