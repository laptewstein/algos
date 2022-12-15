# Vlad Milshtein, Dec 13th 2022

# 1) playing cards
# =================
# A playing card can be represented as a two-character string. The first
# character is the suit and one of S (spades), H (hearts), D,
# (diamonds), and C (clubs). The second character is the rank and one of
# 2-9, T (10), J (jack), Q (queen), K (king), and A (ace). So the 10 of
# spades would be written as "ST", the 2 of diamonds would be "D2",
# etc.

# 1) Write a function to take a two character "playing card" and
# return a structure that contains the suit as a string ("spade",
# "heart", "diamond", "club") and the rank as an integer in the range
# 0-12 for where 0 represents a 2 and 12 represents an ace.

# 2) Use the function from 1) above and write another function which
# sums the ranks of a list of "playing cards". Run your function with
# the input:

# ["HT", "D5", "CA"] # = 23
# ----------------------------------

SUITS = {
  'D' => "Diamonds",
  'C' => "Clubs",
  'H' => "Hearts",
  'S' => "Spades",
}

RANKS = {
  'A' => 12,
  'K' => 11,
  'Q' => 10,
  'J' => 9,
  'T' => 8,
}

def parse_card(str, value_only: false)
  return unless str.size == 2

  suit_raw, rank_raw = str.chars
  suit = SUITS[suit_raw]
  value = rank_raw !~ /^\d$/ ? RANKS[rank_raw] : rank_raw.to_i - 2
  value_only ? value : "#{suit} #{value}"
end

["H5", 'CJ'].zip(['Hearts 3', 'Clubs 9']).each do |card, human_readable_format|
  puts parse_card(card) == human_readable_format
end

def sum_cards(cards)
  cards.sum { |card| parse_card(card, value_only: true) }
end

puts sum_cards(["HT", "D5", "CA"]) == 23
# ----------------------------------


# 2) sql task
# =================
# Greetings SQL Guru!
#
# The task is to write code that mimics the computation of a few SQL queries.
# Don't worry, you don't have to write a parser! Just read in a comma delimited
# flat file 'input.txt' and output the results of the following queries:
#

# The output of your solution will be diff'd with the contents of 'output.txt'
#
# You can write the solution in any language provided that any compilation or setup is
# done in the 'build' script and the command to run the solution is named 'sql'.

require 'csv'
data = "name,age,state\nSam,20,VA\nJoe,20,VA\nSally,18,MD\nSam,24,FL\nJake,12,CO\nSue,49,MA\nLarry,55,CO\nBob,99,WA\nJess,21,MD\nTom,30,VA\n"
dataset = CSV.parse(data, headers: true)

# {"name"=>"Sam", "age"=>"20", "state"=>"VA"}
# {"name"=>"Joe", "age"=>"20", "state"=>"VA"}
# {"name"=>"Sally", "age"=>"18", "state"=>"MD"}
# {"name"=>"Sam", "age"=>"24", "state"=>"FL"}
# {"name"=>"Jake", "age"=>"12", "state"=>"CO"}
# {"name"=>"Sue", "age"=>"49", "state"=>"MA"}
# {"name"=>"Larry", "age"=>"55", "state"=>"CO"}
# {"name"=>"Bob", "age"=>"99", "state"=>"WA"}
# {"name"=>"Jess", "age"=>"21", "state"=>"MD"}
# {"name"=>"Tom", "age"=>"30", "state"=>"VA"}

#   select state,count(*) from table group by state order by count(*) desc
def group_by_state(rows)
  rows
    .group_by { |record| record['state'] }
    .map      { |state, records| [state, records.count] }
    .sort_by  { |_, count| -1 * count }
end

puts group_by_state(dataset).inspect
# => [["VA", 3], ["MD", 2], ["CO", 2], ["FL", 1], ["MA", 1], ["WA", 1]]
# versus expected
# VA,3
# MD,2
# CO,2
# FL,1
# MA,1
# WA,1

# select round(avg(age),1) from table
def average_age(rows, precision = 1)
  age = rows
    .sum { |record| record['age'].to_i }
    .to_f / rows.count
  age.round(precision)
end

puts average_age(dataset)
puts average_age(dataset) == 34.8
# versus expected
# 34.8

# select state,round(avg(age),0) from table group by state order by avg(age)
def average_age_by_state(rows)
  rows
    .group_by { |record| record['state'] }
    .map      { |state, records| [state, average_age(records, 0)] }
    .sort_by  { |_, avg_age| avg_age }
end

puts average_age_by_state(dataset).inspect
# => [["MD", 20], ["VA", 23], ["FL", 24], ["CO", 34], ["MA", 49], ["WA", 99]]
# versus expected
# MD,20
# VA,23
# FL,24
# CO,34
# MA,49
# WA,99

# select state,round(avg(age),0) from table where age > 15 AND age < 55 group by state order by state
def average_age_within_range(rows, age_range = 0...121)
  rows
    .select   { |record| age_range.include?(record['age'].to_i) }
    .group_by { |record| record['state'] }
    .sort_by  { |state, _| state }
    .map      { |state, records| [state, average_age(records, 0)] }
end

puts average_age_within_range(dataset, 15...55).inspect
# => [["FL", 24], ["MA", 49], ["MD", 20], ["VA", 23]]
# versus expected
# FL,24
# MA,49
# MD,20
# VA,23
# ----------------------------------


# 3) happy (lucky) numbers:
# =================
# Full disclosure: I've solved this before. 

# See: https://github.com/Kartoshka548/algos/blob/master/two_pointers/fast_slow_tortoise_and_hare/squares_of_digits_cycle.rb

# In a few words, this is a variation of: 
#   - Floyd's cycle detection algorithm (a classic linked list question!), in compressed form 
#     (no requirement of detection of the node where cycle begins. 
#     See https://github.com/Kartoshka548/algos/blob/master/two_pointers/fast_slow_tortoise_and_hare/find_duplicate_in_array.rb#L21-L22
#   - And the square of a num is a simple while loop stripping the last digit with modulo in each stroke, until num == 0.

# ********
# You're certainly more than welcomed to take a look at any other algo in that repo (there are more in each folder than what readme.md links to) - and reach out with questions! :-)
# ----------------------------------

