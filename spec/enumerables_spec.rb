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
      expect([1,2,3,4].my_each { |i| i * 2 }).to eql([1,2,3,4])
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
      expect(hash).to eql({"cat"=>0, "dog"=>1, "wombat"=>2})
    end

    it 'executes the block for each element of the Range its called on' do
      array = []
      (1..5).my_each_with_index { |item, index| array << (item + index) }
      expect(array).to eql([1, 3, 5, 7, 9])
    end

    it 'returns the Array it was called upon' do
      expect([1,2,3,4].my_each_with_index { |i| i * 2 }).to eql([1,2,3,4])
    end

    it 'returns the Range it was called upon' do
      expect((1..5).my_each_with_index { |i| i * 2 }).to eql((1..5))
    end

    it 'returns Enumerator if no block is given' do
      expect([6, 7, 8, 9].my_each_with_index.class).to eql(Enumerator)
    end
  end
end