module Enumerable
  def my_each()
    i = 0
    while i < size
      return to_enum unless block_given?

      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < size
      return to_enum unless block_given?

      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    selected_array = []
    i = 0
    while i < size
      return to_enum unless block_given?

      selected_array << self[i] if yield(self[i])
      i += 1
    end
    selected_array
  end

  def my_all?(param = nil)
    bool = true
    bool = false if include?(false) || include?(nil)
    my_each do |n|
      if block_given?
        bool = false unless yield(n)
      elsif n.class <= param
        bool = false unless n == param
      elsif n.class != param
        bool = false
      elsif 
        regex = Regexp.new param
        bool = false unless n.to_s.match?(regex)
      end
      break unless bool
    end
    bool
  end

  def my_any?
    i = 0
    while i < size
      return true if block_given? && yield(self[i])
      return true if !self[i] == false && !self[i].nil?

      i += 1
    end
    false
  end

  def my_none?
    i = 0
    while i < size
      if block_given?
        return false if yield(self[i])
      elsif !self[i] == false && !self[i].nil?
        return false
      end

      i += 1
    end
    true
  end

  def my_count(item = nil)
    return size if !block_given? && item.nil?

    count = 0
    my_each do |n|
      count += 1 if (block_given? && yield(n)) || (n == item)
    end
    count
  end

  def my_map(&proc)
    return to_enum unless block_given?

    array = to_a
    mapped_array = []
    i = 0

    while i < array.size
      mapped_array << proc.call(array[i])
      i += 1
    end
    mapped_array
  end

  def my_inject(param1 = nil, param2 = nil)
    array = to_a
    accumulator = array[0]
    i = 1

    accumulator = yield(param1, accumulator) if block_given? && !param1.nil?
    while i < array.size
      accumulator = if block_given?
                      yield(accumulator, array[i])
                    elsif param2.nil?
                      accumulator.send(param1, array[i])
                    else
                      accumulator.send(param2, array[i]).send(param2, param1)
                    end
      i += 1
    end
    accumulator
  end
end
