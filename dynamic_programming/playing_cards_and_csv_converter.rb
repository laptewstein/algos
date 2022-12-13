# 1) playing cards
# =================
# A playing card can be represented as a two-character string. The first
# character is the suit and one of S (spades), H (hearts), D,
# (diamonds), and C (clubs). The second character is the rank and one of
# 2-9, T (10), J (jack:9), Q (queen:10), K (king:11), and A (ace:12).

# So the 10 of spades would be written as "ST", the 2 of diamonds would be "D2", etc.

# 1) Write a function to take a two character "playing card" and
# return a structure that contains the suit as a string ("spade",
# "heart", "diamond", "club") and the rank as an integer in the range
# 0-12 for where 0 represents a 2 and 12 represents an ace.

# 2) Use the function from above and write another function which
# sums the ranks of a list of "playing cards". Run your function with
# the input:

# ["HT", "D5", "CA"] # = 23
# 'CJ' => "Clubs 9"

SUITS = {
  'D' => "Diamonds",
  'C' => "Clubs",
  'H' => "Hearts",
  'S' => "Spades",
}

RANKS = {
  'A' => ["Ace", 12],
  'K' => ["King", 11],
  'Q' => ["Queen", 10],
  'J' => ["Jack", 9],
  'T' => ["Ten", 8],
  '2' => "Two",
  '3' => "Three",
  '4' => "Four",
  '5' => "Five",
  '6' => "Six",
  '7' => "Seven",
  '8' => "Eight",
  '9' => "Nine",
}

def parse_card(str)
  suit_raw, value_raw = str[0], str[1]
  suit  = SUITS[suit_raw]
  if value_raw.to_i == 0
    value = RANKS[value_raw].last
  else
    value = value_raw.to_i - 2
  end
  [suit, value]
end

["H2", 'CJ'].each do |card|
  puts parse_card(card).join(' ')
end

def sum_cards(cards)
  cards.sum do |card|
    values = parse_card(card)
    puts values
    values.last
  end
end

puts sum_cards(["HT", "D5", "CA"])
puts sum_cards(["HT", "D5", "CA"]) == 23
# -----


2) sql task
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
dataset = CSV.parse(data, headers: true).each { |r| puts r.to_h }

# {"name"=>"Sam", "age"=>"20", "state"=>"VA"}
# {"name"=>"Joe", "age"=>"20", "state"=>"VA"}
# {"name"=>"Sally", "age"=>"18", "state"=>"MD"}
# {"name"=>"Sam", "age"=>"24", "state"=>"FL"}
# {"name"=>"Jake", "age"=>"12", "state"=>"CO"}
# {"name"=>"Sue", "age"=>"49", "state"=>"A"}
# {"name"=>"Larry", "age"=>"55", "state"=>"CO"}
# {"name"=>"Bob", "age"=>"99", "state"=>"WA"}
# {"name"=>"Jess", "age"=>"21", "state"=>"MD"}
# {"name"=>"Tom", "age"=>"30", "state"=>"VA"}

#   select state,count(*) from table group by state order by count(*) desc
def group_by_state(rows)
  rows
    .group_by { |record| record['state'] }
    .map { |state, records| [state, records.count] }
    .sort_by {|state, count| -1 * count }
end

puts group_by_state(dataset).inspect
# [["VA", 3], ["MD", 2], ["CO", 2], ["FL", 1], ["MA", 1], ["WA", 1]]
# expected
# VA,3
# MD,2
# CO,2
# FL,1
# MA,1
# WA,1

#   select round(avg(age),1) from table
def avg_round(rows)
  sum = rows.sum { |record| record['age'].to_i }
  (sum.to_f / rows.count).round(1)
end

puts avg_round(dataset)
puts avg_round(dataset) == 34.8
# expected
# 34.8

# rest is unfinished due to time contraints
#   select state,round(avg(age),0) from table group by state order by avg(age)
#   select state,round(avg(age),0) from table where age > 15 AND age < 55 group by state order by state
