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

  def my_all?
    i = 0
    while i < size
      return false if block_given? && !yield(self[i])

      return false if self[i] == false || self[i].nil?

      i += 1
    end
    true
  end

  def my_any?
    i = 0
    while i < size
      return true if block_given? && yield(self[i])

      return false if self[i] == false || self[i].nil?

      i += 1
    end
    false
  end

  def my_none?
    i = 0
    while i < size
      return false if block_given? && yield(self[i])

      return false if self[i] == false || self[i].nil?

      i += 1
    end
    true
  end

  def my_count
    return size unless block_given?

    count = 0
    i = 0
    while i < size
      count += 1 if yield(self[i])

      i += 1
    end

    count
  end
end
