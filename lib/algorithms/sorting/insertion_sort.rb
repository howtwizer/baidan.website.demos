module Algorithms
  module Sorting

    # Fast on small arrays o(n) but
    # IN general O(n^2)
    # @param [Array] a
    # @return [Array] sorted array
    def self.insertion_sort(a)
      (1..a.length - 1).each do |j|
        key = a[j]
        i = j - 1
        while i > -1 && a[i] > key
          a[i + 1] = a[i]
          i -= 1
        end
        a[i + 1] = key
      end
      a
    end

  end
end
