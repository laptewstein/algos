def k_way_merge(*args)
  sorted_array = args.clone
  while sorted_array.size > 1
    left  = sorted_array.shift
    right = sorted_array.shift
    sorted_array << merge_two_lists(left, right)
  end
  sorted_array.first
end


def merge_two_lists(left, right)
  l, r = 0, 0
  final_array = []
  while l < left.size && r < right.size
    if left[l] > right[r]
      final_array << right[r] unless right[r] == final_array.last
      r = r.succ
    else
      final_array << left[l] unless left[l] == final_array.last
      l = l.succ
    end
  end
  while l < left.size
    final_array << left[l] unless left[l] == final_array.last
    l = l.succ
  end
  while r < right.size
    final_array << right[r] unless right[r] == final_array.last
    r = r.succ
  end
  final_array
end

a = [26, -52, 48, 35, 75, 40, 14, -25, -23, 45, 28, 82, 63, -99, 62, 96, -99, -85, 37, -20].sort
b = [-28, 19, 14, -27, 44, 79, -96, 24, 78, -48, 7, -99, -68, -38, 65, 82, -94, -17, -98, 43, -36].sort
c = [17, 12, 95, -66, 18, -12, -72, -62, 45, -18, -25, -69, -27, 14, -36, -29, 71, 22, -76, 67].sort
d = [-43, -62, -95, 35, -6, 62, -14, 53, 8, -57, -33, 82, 64, -96, -10, 89, 94, 22, -84, -9].sort
e = [15, -71, -17, 95, -38, 74, -36, 38, -50, -93, 17, 35, 47, 7, 49, 61, 21, -96, -69, -8].sort

merge_two_lists(a, b)
[-99, -98, -96, -94, -85, -68, -52, -48, -38, -36, -28, -27, -25, -23, -20, -17, 7, 14, 19, 24, 26, 28, 35, 37, 40, 43, 44, 45, 48, 62, 63, 65, 75, 78, 79, 82, 96]
k_way_merge(a, b, c, d, e)
[-99, -98, -96, -95, -94, -93, -85, -84, -76, -72, -71, -69, -68, -66, -62, -57, -52, -50, -48, -43, -38, -36, -33, -29, -28, -27, -25, -23, -20, -18, -17, -14, -12, -10, -9, -8, -6, 7, 8, 12, 14, 15, 17, 18, 19, 21, 22, 24, 26, 28, 35, 37, 38, 40, 43, 44, 45, 47, 48, 49, 53, 61, 62, 63, 64, 65, 67, 71, 74, 75, 78, 79, 82, 89, 94, 95, 96]
