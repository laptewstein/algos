def rle(string)
  trailing_count = 0
  construct      = ''
  (0...string.length).each do |idx|
    current = string[idx]
    trailing_count += 1 and next if construct[-1] == current

    if trailing_count > 0
      construct << trailing_count.succ.to_s
      trailing_count = 0
    end
    construct << current
  end
  return construct if trailing_count == 0
  construct + "#{trailing_count + 1}"
end


def rle(string, prev = '', idx = 0, count = 1)
  if idx == string.length
    retval = "#{prev}"
    return count == 1 ? retval : retval + count.to_s
  end

  if string[idx] == prev
    rle(string, prev, idx.succ, count.succ)
  else
    rle(string, prev, string.length, count) + rle(string, string[idx], idx.succ, 1)
  end
end

puts rle('aaaaabbbaa') == 'a5b3a2'