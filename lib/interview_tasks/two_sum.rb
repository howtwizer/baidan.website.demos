# Given an array of integers and a target integer, return indices of two array elements such that the elements add up to the target.
# [2, 15, 7, 11]
# 9 -> [0,2]
# 18 -> [2,3]

# bruteforce
def two_sum_btf(array, target)
  # sorted_array = array.sort # O(n*log(n))
  #
  # return [-1] if sorted_array[0] > target || sorted_array[0] > (target - 1) / 2
  # return [0] if sorted_array[0] = target

  array.each_with_index do |e, i|
    array.each_with_index do |o, j|
      if e + o == target
        return [i, j]
      end
    end
  end
  [-1, -1]
end

# fast hash
def two_sum(array, target)
  h = {}
  array.each_with_index do |e, i|
    if h.has_key?(target-e)
      return [h[target-e], i]
    end
    h[e] = i
  end
  [-1,-1]
end

puts "two_sum_btf #{two_sum_btf([2, 15, 7, 11], 9)}"
puts "-----------"
puts "two_sum #{two_sum([2, 15, 7, 11], 9)}"
