require_relative '../lion'
 
describe Lion do
  let(:lion) { Lion.new }
  describe 'Warm-up Round' do
    it 'should print roar' do
      expect { lion.roar }.to output(/roar/).to_stdout
    end
  end
  describe 'Data Structures' do
    it 'remembers which foods it has eaten' do
      lion.eat('candy')
      lion.eat('kitty')
      # Note `contain_exactly` does not compare order
      expect(lion.foods_consumed).to contain_exactly('candy', 'kitty')
    end
    it 'only remembers unique foods, it does not keep track of duplicates' do
      lion.eat('candy')
      lion.eat('kitty')
      lion.eat('kitty')
      lion.eat('buffalo')
  
      expect(lion.foods_consumed).to contain_exactly('candy', 'kitty', 'buffalo')
    end
  end
  describe 'Algorithms' do
    it 'raises an error when attempting to eat a palindrome' do
      lion.eat('candy')
      lion.eat('buffalo')
      expect { lion.eat('racecar') }.to raise_error('PalindromeError')
      expect(lion.foods_consumed).to contain_exactly('candy', 'buffalo')
    end
    it 'has a list of Favorite Foods which are foods with an odd number of letters' do
      lion.eat('candy')
      lion.eat('computer')
      lion.eat('apple')
      lion.eat('pear')
      lion.eat('apple')
      expect(lion.favorite_foods).to contain_exactly('candy', 'apple')
    end
    it 'replaces any food name containing the exact same set of characters, irrespective of order' do
      lion.eat('apple')
      lion.eat('grass')
      expect(lion.foods_consumed).to contain_exactly('apple', 'grass')
      expect(lion.favorite_foods).to contain_exactly('apple', 'grass')
      lion.eat('ppael')
      expect(lion.foods_consumed).to contain_exactly('grass', 'ppael')
      expect(lion.favorite_foods).to contain_exactly('grass', 'ppael')
    end
    it 'digests foods in reverse alphabetical order' do
      lion.eat('apple')
      lion.eat('grass')
      lion.eat('zebra')
      lion.eat('orange')
      expect(lion.digest).to eq('zebra')
      expect(lion.digest).to eq('orange')
      expect(lion.digest).to eq('grass')
      expect(lion.digest).to eq('apple')
      expect(lion.digest).to be_nil
      expect(lion.foods_consumed).to be_empty
      expect(lion.favorite_foods).to be_empty
    end
  end
end

