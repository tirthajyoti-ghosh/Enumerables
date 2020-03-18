require_relative 'spec_helper'
require_relative '../enumerables.rb'

RSpec.describe Enumerable do
  describe '#my_each' do
    let(:array) { [] }
    it 'executes the block for each element of the Array its called on' do
      [6, 7, 4, 8].my_each { |n| array << (n + 1) }
      expect(array).to eql([7, 8, 5, 9])
    end

    it 'executes the block for each element of the Range its called on' do
      (1..10).my_each { |item| array << item }
      expect(array).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    end

    it 'returns the Array it was called upon' do
      expect([1, 2, 3, 4].my_each { |i| i * 2 }).to eql([1, 2, 3, 4])
    end

    it 'returns the Range it was called upon' do
      expect((1..5).my_each { |i| i * 2 }).to eql((1..5))
    end

    it 'returns Enumerator if no block is given' do
      expect([6, 7, 8, 9].my_each.class).to eql(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'executes the block for each element and its index of the Array its called on' do
      hash = {}
      %w[cat dog wombat].my_each_with_index { |item, index| hash[item] = index }
      expect(hash).to eql('cat' => 0, 'dog' => 1, 'wombat' => 2)
    end

    it 'executes the block for each element of the Range its called on' do
      array = []
      (1..5).my_each_with_index { |item, index| array << (item + index) }
      expect(array).to eql([1, 3, 5, 7, 9])
    end

    it 'returns the Array it was called upon' do
      expect([1, 2, 3, 4].my_each_with_index { |i| i * 2 }).to eql([1, 2, 3, 4])
    end

    it 'returns the Range it was called upon' do
      expect((1..5).my_each_with_index { |i| i * 2 }).to eql((1..5))
    end

    it 'returns Enumerator if no block is given' do
      expect([2, 1, 6, 7, 4, 8].my_each_with_index.class).to eql(Enumerator)
    end
  end

  describe '#my_select' do
    it 'returns elements of the array that meets the condition in given block' do
      expect([2, 1, 6, 7, 4, 8, 10].my_select(&:even?)).to eql([2, 6, 4, 8, 10])
    end

    it 'returns Enumerator if no block is given' do
      expect([1, 6, 7, 4].my_select.class).to eql(Enumerator)
    end
  end

  describe '#my_all?' do
    it 'returns true if condition in block is true for all the elements in the array' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'returns false if condition in block is not true for all the elements in the array' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it 'returns true if the array is empty' do
      expect([].my_all?).to eql(true)
    end

    describe 'when no parameter and no block given' do
      it 'returns true if none of the element is nil/false in array' do
        expect(['nil', true, 99].my_all?).to eql(true)
      end

      it 'returns false if any one of the element is nil/false in array' do
        expect([nil, false, 9].my_all?).to eql(false)
      end
    end

    describe 'when one parameter is present and no block given' do
      describe 'when parameter is a Numeric' do
        it 'returns true if the Integer in the parameter is equal to all the elements in array' do
          expect([3, 3, 3, 3, 3].my_all?(3)).to eql(true)
        end

        it 'returns false if the Integer in the parameter is not equal to all the elements in array' do
          expect([2, 1, 6, 7, 4, 8, 10].my_all?(5)).to eql(false)
        end

        it 'returns true if the Float in the parameter is equal to all the elements in array' do
          expect([32.3, 32.3, 32.3, 32.3, 32.3].my_all?(32.3)).to eql(true)
        end

        it 'returns false if the Float in the parameter is not equal to all the elements in array' do
          expect([32.3, 32.3, 32, 32.3, 33.3].my_all?(32.3)).to eql(false)
        end
      end

      describe 'when parameter is Pattern' do
        it 'returns true if the Pattern in the parameter matches with all the elements in array' do
          expect(%w[cat cat cat].my_all?('cat')).to eql(true)
        end

        it 'returns false if the Pattern in the parameter does not match with all the elements in array' do
          expect(%w[ant bear cat].my_all?('cat')).to eql(false)
        end
      end

      describe 'when parameter is Regexp' do
        it 'returns true if the Regexp in the parameter matches with all the elements in array' do
          expect(%w[ant bear cat].my_all?(/a/)).to eql(true)
        end

        it 'returns false if the Regexp in the parameter does not match with all the elements in array' do
          expect(%w[ant bear cat].my_all?(/d/)).to eql(false)
        end
      end

      describe 'when parameter is Class/Superclass' do
        it 'returns true if the Class in the parameter is a Superclass of all the elements in array' do
          expect([1, 5i, 5.67].my_all?(Numeric)).to eql(true)
        end

        it 'returns false if the Class in the parameter is not a Superclass of all the elements in array' do
          expect([1, 5i, 5.67, true].my_all?(Numeric)).to eql(false)
        end

        it 'returns true if the Class in the parameter is the Class of all the elements in array' do
          expect([2, 1, 6, 7, 4, 8, 10].my_all?(Integer)).to eql(true)
        end

        it 'returns false if the Class in the parameter is not the Class of all the elements in array' do
          expect(['1', '5i', 5.67, 'true'].my_all?(String)).to eql(false)
        end
      end
    end
  end

  describe '#my_any?' do
    it 'returns true if condition in block is true for any one of the elements in the array' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to eql(true)
    end

    it 'returns false if condition in block is not true for any of the elements in the array' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 5 }).to eql(false)
    end

    it 'returns false if the array is empty' do
      expect([].my_any?).to eql(false)
    end

    describe 'when no parameter and no block given' do
      it 'returns true if any one of the element is not nil/false in array' do
        expect([nil, false, 9].my_any?).to eql(true)
      end

      it 'returns false if any all of the element is nil/false in array' do
        expect([nil, false, nil].my_any?).to eql(false)
      end
    end

    describe 'when one parameter is present and no block given' do
      describe 'when parameter is a Numeric' do
        it 'returns true if the Integer in the parameter is equal to any one of the elements in array' do
          expect([2, 1, 6, 7, 4, 8, 10].my_any?(7)).to eql(true)
        end

        it 'returns false if the Integer in the parameter is not equal to any one of the elements in array' do
          expect([2, 1, 6, 7, 4, 8, 10].my_any?(5)).to eql(false)
        end

        it 'returns true if the Float in the parameter is equal to any one of the elements in array' do
          expect([3, 56.3, 32.3, 323, 58.1].my_any?(32.3)).to eql(true)
        end

        it 'returns false if the Float in the parameter is not equal to any one of the elements in array' do
          expect([32.5, 32.7, 31, 42.3, 37].my_any?(32.3)).to eql(false)
        end
      end

      describe 'when parameter is Pattern' do
        it 'returns true if the Pattern in the parameter matches with any one of the elements in array' do
          expect(%w[cat fruit bat].my_any?('cat')).to eql(true)
        end

        it 'returns false if the Pattern in the parameter does not match with any one of the elements in array' do
          expect(%w[ant bear cat].my_any?('bread')).to eql(false)
        end
      end

      describe 'when parameter is Regexp' do
        it 'returns true if the Regexp in the parameter matches with any one of the elements in array' do
          expect(%w[ant bear cat].my_any?(/a/)).to eql(true)
        end

        it 'returns false if the Regexp in the parameter does not match with any one of the elements in array' do
          expect(%w[ant bear cat].my_any?(/d/)).to eql(false)
        end
      end

      describe 'when parameter is Class/Superclass' do
        it 'returns true if the Class in the parameter is a Superclass of any one of the elements in array' do
          expect([1, 5i, 5.67].my_any?(Numeric)).to eql(true)
        end

        it 'returns false if the Class in the parameter is not a Superclass of any one of the elements in array' do
          expect(['1', Integer, [1, 2, 3], true].my_any?(Numeric)).to eql(false)
        end

        it 'returns true if the Class in the parameter is the Class of any one of the elements in array' do
          expect([2, 1, 6, 7, 4, 8, 10].my_any?(Integer)).to eql(true)
        end

        it 'returns false if the Class in the parameter is not the Class of any one of the elements in array' do
          expect([1, 5i, 5.67, true].my_any?(String)).to eql(false)
        end
      end
    end
  end

  describe '#my_none?' do
    it 'returns true if condition in block is true for none the elements in the array' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 5 }).to eql(true)
    end

    it 'returns false if condition in block is not true for none the elements in the array' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 4 }).to eql(false)
    end

    it 'returns true if the array is empty' do
      expect([].my_none?).to eql(true)
    end

    describe 'when no parameter and no block given' do
      it 'returns true if none of the element is not nil/false in array' do
        expect([nil, false, false].my_none?).to eql(true)
      end

      it 'returns false if any one of the element is nil/false in array' do
        expect([nil, false, 9].my_none?).to eql(false)
      end
    end

    describe 'when one parameter is present and no block given' do
      describe 'when parameter is a Numeric' do
        it 'returns true if the Integer in the parameter is equal to none the elements in array' do
          expect([6, 7, 4, 8, 3].my_none?(5)).to eql(true)
        end

        it 'returns false if the Integer in the parameter is equal to any one of the elements in array' do
          expect([2, 1, 6, 7, 4, 8, 10].my_none?(2)).to eql(false)
        end

        it 'returns true if the Float in the parameter is equal to none the elements in array' do
          expect([32.5, 32.7, 31, 42.3, 37].my_none?(32.3)).to eql(true)
        end

        it 'returns false if the Float in the parameter is not equal to none the elements in array' do
          expect([31, 42.3, 37, 32.3, 33.3].my_none?(32.3)).to eql(false)
        end
      end

      describe 'when parameter is Pattern' do
        it 'returns true if the Pattern in the parameter matches with none the elements in array' do
          expect(%w[cats dogs bats].my_none?('cat')).to eql(true)
        end

        it 'returns false if the Pattern in the parameter matches with any of the elements in array' do
          expect(%w[ant bear cat].my_none?('cat')).to eql(false)
        end
      end

      describe 'when parameter is Regexp' do
        it 'returns true if the Regexp in the parameter matches with none the elements in array' do
          expect(%w[ant bear cat].my_none?(/d/)).to eql(true)
        end

        it 'returns false if the Regexp in the parameter does not match with none the elements in array' do
          expect(%w[ant bear cat].my_none?(/a/)).to eql(false)
        end
      end

      describe 'when parameter is Class/Superclass' do
        it 'returns true if the Class in the parameter is a Superclass of none the elements in array' do
          expect(['1', true, [5.67]].my_none?(Numeric)).to eql(true)
        end

        it 'returns false if the Class in the parameter is not a Superclass of none the elements in array' do
          expect([1, 5i, 5.67, 41].my_none?(Numeric)).to eql(false)
        end

        it 'returns true if the Class in the parameter is the Class of none the elements in array' do
          expect([2, 1, 6, 7, 4, 8, 10].my_none?(String)).to eql(true)
        end

        it 'returns false if the Class in the parameter is not the Class of none the elements in array' do
          expect(['1', '5i', 5.67, 'true'].my_none?(String)).to eql(false)
        end
      end
    end
  end

  describe '#my_count' do
    it 'retuurns the length of the array its called on if no block or parameter is given' do
      expect([1, 2, 4, 2].my_count).to eql(4)
    end

    it 'returns the number of the elements that matches the parameter' do
      expect([1, 2, 4, 2].my_count(2)).to eql(2)
    end

    it 'returns the number of the elements that matches the condition given in block' do
      expect([1, 2, 4, 2].my_count { |x| x > 1 }).to eql(3)
    end
  end

  describe '#my_map' do
    it 'returns a new array after executing the block on each element of the Array its called on' do
      expect([5, 1, 3, 4, 2].my_map { |n| n + 2 }).to eql([7, 3, 5, 6, 4])
    end

    it 'returns a new array after executing the block on each element of the Range its called on' do
      expect((1..4).my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end

    it 'returns a new array after executing the proc on each element of the Array its called on' do
      arr_proc = proc { |n| n * 2 }
      expect([2, 3, 5, 6, 1, 7, 5, 3, 9].my_map(&arr_proc)).to eql([4, 6, 10, 12, 2, 14, 10, 6, 18])
    end

    it 'returns a new array after executing the proc and block on a chain on each element of Array' do
      arr_proc = proc { |n| n * 2 }
      expect([2, 3, 5, 6, 1, 7, 5, 3, 9].my_map(&arr_proc)
                                        .my_map { |n| n + 1 }).to eql([5, 7, 11, 13, 3, 15, 11, 7, 19])
    end
  end

  describe '#my_inject' do
    describe 'when no block given and one parameter present' do
      it 'returns a combined value of the Range its called on specified by the operator symbol in parameter' do
        expect((5..10).my_inject(:+)).to eql(45)
      end

      it 'returns a combined value of the Array its called on specified by the operator symbol in parameter' do
        expect([2, 3, 5, 6, 1, 7, 5, 3, 9].my_inject(:+)).to eql(41)
      end
    end

    describe 'when no parameter present and block given' do
      it 'returns a combined value of the Array its called on specified by the block' do
        expect((5..10).my_inject { |sum, n| sum + n }).to eql(45)
      end

      it 'returns a combined value of the Array its called on specified by the block' do
        expect([2, 3, 5, 6, 1, 7, 5, 3, 9].my_inject { |sum, n| sum + n }).to eql(41)
      end
    end

    describe 'when two parameters present and no block given' do
      it 'returns a combined value of  1st param and Range specified by symbol in 2nd param' do
        expect((5..10).my_inject(1, :*)).to eql(151_200)
      end

      it 'returns a combined value of 1st param and Array specified by symbol in 2nd param' do
        expect([2, 3, 5, 6, 1, 7, 5, 3, 9].my_inject(1, :*)).to eql(170_100)
      end
    end

    describe 'when one parameter present and block given' do
      it 'returns a combined value of the Range specified by the block after combining the parameter to 1st element' do
        expect((5..10).my_inject(1) { |product, n| product * n }).to eql(151_200)
      end

      it 'returns a combined value of the Array specified by the block after combining the parameter to 1st element' do
        expect([2, 3, 5, 6, 1, 7, 5, 3, 9].my_inject(1) { |product, n| product * n }).to eql(170_100)
      end
    end
  end
end
