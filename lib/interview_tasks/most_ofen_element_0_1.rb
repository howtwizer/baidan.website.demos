module InterviewTasks
  # @description
  # You are given a list of n elements
  # (integers with values  between 0 and 99 that can appear more than once in the list),
  # and you should find the element that appears most often,
  # and you are allowed to go trough the list just once
  #
  # @example
  # most_often([1,2,3,4,44,2,23,2,2]) -> 2
  #
  # @param [Array]
  #
  # @return [Integer] Most often element, or if all elements only once in list - last element of list
  def most_often(array)
    a = []
    max_index = 0
    max_value = 0
    array.each do |e|
      # Increment array key with element number or init with 1
      a[e].nil? ? a[e] = 1 : a[e] += 1
      # If max_value (count of numbers in array)
      max_value, max_index = a[e], e if max_value <= a[e]
    end
    return max_index
  end
end
