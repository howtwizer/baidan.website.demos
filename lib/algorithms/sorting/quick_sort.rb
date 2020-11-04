module Algorithms
  module Sorting

    def quick_sort(array)
      return array if array.length <= 1

      pivot = array.delete_at(rand(array.length))

      left = []
      right = []

      array.each do |x|
        if x < pivot
          left << x
        else
          right << x
        end
      end

      return *quick_sort(left), pivot, *quick_sort(right)

    end

  end
end
