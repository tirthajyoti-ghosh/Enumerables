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
end
