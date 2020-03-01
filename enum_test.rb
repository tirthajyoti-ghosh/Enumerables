require_relative 'enumerables.rb'

class Array
  prepend Enumerable
end

# Test method for #my_map
def multiply_els(arr)
  arr.my_inject(1) { |product, n| product * n }
end

puts '-' * 40
# Test for #my_each
puts 'Test for #my_each'
puts
%w[a b c].my_each { |x| print x, ' -- ' }
puts
puts '-' * 40

puts '-' * 40
# Test for #my_each_with_index
puts 'Test for #my_each_with_index'
puts
hash = {}
%w[cat dog wombat].my_each_with_index { |item, index| hash[item] = index }
print hash
puts
puts '-' * 40

puts '-' * 40
# Test for #my_select
puts 'Test for #my_select'
puts
print([2, 1, 6, 7, 4, 8, 10].my_select(&:even?))
puts
puts '-' * 40

puts '-' * 40
# Test for #my_all
puts 'Test for #my_all'
puts
puts(%w[ant bear cat].all? { |word| word.length >= 3 })
puts(%w[ant bear cat].all? { |word| word.length >= 4 })
puts [nil, true, 99].all?
puts [].all?
puts '-' * 40

puts '-' * 40
# Test for #my_any
puts 'Test for #my_any'
puts
puts(%w[ant bear cat].my_any? { |word| word.length >= 3 })
puts(%w[ant bear cat].my_any? { |word| word.length >= 4 })
puts [nil, true, 99].my_any?
puts [].my_any?
puts '-' * 40
