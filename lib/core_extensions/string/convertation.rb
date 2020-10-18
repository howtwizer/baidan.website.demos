module CoreExtensions
  module String
    module Convertation
      # @description
      # Convert String like '1,2,3'
      # to Array
      # Add string conversion to nil to hold unassignee filters
      # [6] pry(main)> 'unassigned,2,3'.split(',').map{|s| i =s.to_i; i == 0?nil:i}
      # => [nil, 2, 3]
      # @return [Array]
      def to_array
        split(',').map { |s| i = s.to_i; i == 0 ? nil : i }
      end
    end
  end
end

String.include CoreExtensions::String::Convertation