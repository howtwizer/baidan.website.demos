module Algorithms
  module Sorting

    # @param [Array] a
    # @return [Array] sorted array
    def self.selection_sort(a)
      n = a.length - 1
      (0..n - 1).each do |j|
        smallest = j
        (j + 1..n).each do |i|
          # searching smallest
          if a[i] < a[smallest]
            smallest = i
          end
        end
        # Exchange
        tmp = a[j]
        a[j] = a[smallest]
        a[smallest] = tmp
      end
      a
    end

  end
end
