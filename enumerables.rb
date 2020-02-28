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
end
