=begin
"""
Problem:

You are given a string formed by concatenating several words corresponding to the
integers zero through nine and then anagramming.

For example, the input could be 'niesevehrtfeev', which is an anagram of
'threefiveseven'. Note that there can be multiple instances of each integer.

Given this string, return the original integers in sorted order. In the example above,
this would be 357.
"""

from collections import Counter
from sys import maxsize
from typing import Counter as C

WORDS = [
    Counter("zero"),
    Counter("one"),
    Counter("two"),
    Counter("three"),
    Counter("four"),
    Counter("five"),
    Counter("six"),
    Counter("seven"),
    Counter("eight"),
    Counter("nine"),
]


def generate_num_helper(counter: C[str]) -> C[int]:
    # runs in O(1) as all the loops run in constant time
    result = Counter()
    for idx, word_counter in enumerate(WORDS):
        temp = maxsize
        for key in word_counter:
            # check number of occurences of current character
            if counter[key] >= word_counter[key]:
                temp = min(temp, counter[key] // word_counter[key])
            else:
                temp = 0
                break
        else:
            # update input counter to remove current digit
            curr_counter = Counter()
            for key in word_counter:
                curr_counter[key] = word_counter[key] * temp
            counter = counter - curr_counter
            result[idx] = temp
    return result


def generate_num(string: str) -> int:
    counter = Counter(string)
    digit_counter = generate_num_helper(counter)

    numbers_list = [str(num) for num in sorted(digit_counter.keys())]
    return int("".join(numbers_list))


if __name__ == "__main__":
    print(generate_num("niesevehrtfeev"))
    print(generate_num("niesveeviehertifennevf"))

=end

require 'enumerator'

WORDS = [
  Hash["zero".each_char.group_by(&:itself).map { |k, v| [k, v.size] }],
  Hash["one".each_char.group_by(&:itself).map { |k, v| [k, v.size] }],
  Hash["two".each_char.group_by(&:itself).map { |k, v| [k, v.size] }],
  Hash["three".each_char.group_by(&:itself).map { |k, v| [k, v.size] }],
  Hash["four".each_char.group_by(&:itself).map { |k, v| [k, v.size] }],
  Hash["five".each_char.group_by(&:itself).map { |k, v| [k, v.size] }],
  Hash["six".each_char.group_by(&:itself).map { |k, v| [k, v.size] }],
  Hash["seven".each_char.group_by(&:itself).map { |k, v| [k, v.size] }],
  Hash["eight".each_char.group_by(&:itself).map { |k, v| [k, v.size] }],
  Hash["nine".each_char.group_by(&:itself).map { |k, v| [k, v.size] }]
]

def generate_num_helper(counter)
  result = Hash.new(0)
  WORDS.each_with_index do |word_counter, value|
    temp = Float::INFINITY
    word_counter.each do |key, _|
      if counter[key].to_i >= word_counter[key].to_i
        temp = [temp, counter[key] / word_counter[key]].min
      else
        temp = 0
        break
      end
    end
    unless temp.zero?
      curr_counter = Hash.new(0)
      word_counter.each do |key, _|
        curr_counter[key] = word_counter[key] * temp
      end
      counter.transform_values! { |v| v - curr_counter[v] }
      result[value] = temp
    end
  end
  result
end

def generate_num(string)
  str_counter = Hash.new(0)
  string.each_char { |c| str_counter[c] += 1 }
  numbers_counter = generate_num_helper(str_counter)

  numbers_list = numbers_counter.flat_map { |num, count| [num.to_s] * count }.sort
  numbers_list.join.to_i
end

puts generate_num("niesevehrtfeev")  # Output: 357
puts generate_num("niesveeviehertifennevf")  # Output: 35579