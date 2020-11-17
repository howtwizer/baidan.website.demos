module InterviewTasks

  # @example
  # list = InterviewTasks::LinkedList.new()
  # list.add(1)
  # list.add(2)
  # list.add(3)
  #
  # list.display(list)                #list before reversing [1,2,3]
  # list.display(list.reverse(list))  #list after reversing  [3,2,1]

  class Node
    attr_accessor :value, :next

    def initialize(value, next_node)
      @value = value
      @node = next_node
    end
  end

  class LinkedList
    attr_accessor :head, :tail

    def add(value)
      if @head.nil?
        @head = Node.new(value, nil)
        @tail = @head
      else
        # Adding next node to tail
        @tail.next = Node.new(value, nil)
        # Setting tail to @tail next node
        @tail = @tail.next
      end
    end

    def reverse(list)
      return nil if list.nil?

      previous = nil
      # Starting from head
      current = list.head
      # In list reverse we are not changing postion of elemetns,
      # we changing linked next nodes!
      while current != nil
        temp = current.next
        current.next = previous
        previous = current
        current = temp
      end
      # Setting new head of list ( = last element of list)
      list.head = previous
      list
    end

    def display(list)
      return nil if list.nil?

      array = []
      current = list.head

      while current != nil
        array << current.value
        current = current.next
      end
      puts array
    end
  end
end
