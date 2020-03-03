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

  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

  def my_all?(param = nil)
    my_each do |n|
      case
      when block_given? then return false unless yield(n)
      when param.is_a?(Regexp) then return false unless n.to_s.match?(param)
      when param.is_a?(Class) then return false unless n.is_a?(param)
      when !param.nil? then return false if n != param
      else return false if include?(false) || include?(nil)
      end
    end
    true
  end

  def my_any?(param = nil)
    my_each do |n|
      case
      when block_given? then return true if yield(n)
      when param.is_a?(Regexp) then return true if n.to_s.match?(param)
      when param.is_a?(Class) then return true if n.is_a?(param)
      when !param.nil? then return true if n == param
      else return true if n != false || !n.nil?
      end
    end
    false
  end

  def my_none?(param = nil)
    my_each do |n|
      case
      when block_given? then return false if yield(n)
      when param.is_a?(Regexp) then return false if n.to_s.match?(param)
      when param.is_a?(Class) then return false if n.is_a?(param)
      when !param.nil? then return false if n == param
      else return false if n != false && !n.nil?
      end
    end
    true
  end

  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

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
