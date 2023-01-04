class PalindromeError < Exception
end
 
class Lion
  attr_reader :foods_consumed
 
  def initialize()
    @foods_consumed = []
  end
 
  def roar
    puts "roars and barks"
  end

  def digest
    item = @foods_consumed.sort.pop
    @foods_consumed.delete(item)
    item
  end

  def eat(arg)
    raise PalindromeError if is_palindrome?(arg)
    # only likes animals with odd number of letters in their name
    unless @foods_consumed.include?(arg)
      duplicate = is_an_anagram(arg)
      @foods_consumed.delete(duplicate) if duplicate
      @foods_consumed << arg
    end 
  end

  def is_an_anagram(arg)
    sorted_arg = arg.downcase.chars.sort.join
    @foods_consumed.detect do |item|
      sorted_item = item.downcase.chars.sort.join
      sorted_arg == sorted_item
    end
  end
  
  def favorite_foods
   @foods_consumed.select { |item| item.length.odd? }
  end

  def is_palindrome?(arg)
    l, r = 0, arg.length.pred
    until l >= r
      return false unless arg[l] == arg[r]
      l = l.succ
      r = r.pred
    end 
    true
  end
end

