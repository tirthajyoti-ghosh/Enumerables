require_relative 'enumerables.rb'

class Array
  prepend Enumerable
end

# Test method for #my_map
def multiply_els(arr)
  arr.my_inject(1) { |product, n| product * n }
end

puts '_' * 40
# Test for #my_each
puts 'Test for #my_each'
%w[a b c].my_each { |x| print x, ' -- ' }
puts

puts '_' * 40
# Test for #my_each_with_index
puts 'Test for #my_each_with_index'
hash = {}
%w[cat dog wombat].my_each_with_index { |item, index| hash[item] = index }
print hash
puts

puts '_' * 40
# Test for #my_select
puts 'Test for #my_select'
print([2, 1, 6, 7, 4, 8, 10].my_select(&:even?))
puts

puts '_' * 40
# Test for #my_all
puts 'Test for #my_all'
puts(%w[ant bear cat].my_all? { |word| word.length >= 3 })
puts(%w[ant bear cat].my_all? { |word| word.length >= 4 })
puts [nil, true, 99].my_all?
puts [].all?

puts '_' * 40
# Test for #my_any
puts 'Test for #my_any'
puts(%w[ant bear cat].my_any? { |word| word.length >= 3 })
puts(%w[ant bear cat].my_any? { |word| word.length >= 4 })
puts [nil, true, 99].my_any?
puts [].my_any?

puts '_' * 40
# Test for #my_none
puts 'Test for #my_none'
puts(%w[ant bear cat].my_none? { |word| word.length == 5 })
puts(%w[ant bear cat].my_none? { |word| word.length >= 4 })
puts [].my_none?
puts [nil].my_none?
puts [nil, false].my_none?
puts [nil, false, true].my_none?

puts '_' * 40
# Test for #my_count
puts 'Test for #my_count'
puts [1, 2, 4, 2].my_count
puts [1, 2, 4, 2].my_count(2)
puts([1, 2, 4, 2].my_count { |x| x > 1 })

puts '_' * 40
# Test for #my_map
puts 'Test for #my_map'
print((1..4).my_map { |i| i * i })
puts
print([5, 1, 3, 4, 2].my_map { |n| n + 2 })
puts
arr_proc = proc { |n| n * 2 }
print [2, 3, 5, 6, 1, 7, 5, 3, 9].my_map(&arr_proc)
puts
print([2, 3, 5, 6, 1, 7, 5, 3, 9].my_map(&arr_proc).my_map { |n| n + 1 })
puts

puts '_' * 40
# Test for #my_inject
puts 'Test for #my_inject'
puts((5..10).my_inject(:+))
puts([2, 3, 5, 6, 1, 7, 5, 3, 9].my_inject(:+))
puts((5..10).my_inject { |sum, n| sum + n })
puts([2, 3, 5, 6, 1, 7, 5, 3, 9].my_inject { |sum, n| sum + n })
puts((5..10).my_inject(1, :*))
puts([2, 3, 5, 6, 1, 7, 5, 3, 9].my_inject(1, :*))
puts((5..10).my_inject(1) { |product, n| product * n })
puts([2, 3, 5, 6, 1, 7, 5, 3, 9].my_inject(1) { |product, n| product * n })
longest = %w[cat sheep bear].my_inject { |memo, word| memo.length > word.length ? memo : word }
puts longest
# Testing #multiply_els
puts multiply_els([2, 4, 5])
puts '_' * 40
