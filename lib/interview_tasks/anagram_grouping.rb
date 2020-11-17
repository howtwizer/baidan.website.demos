module InterviewTasks

  # @example
  # for example if we have a list :
  # ['hello', 'ehllo', 'hi', 'lisp', 'pisl']
  # then we print:
  # hello, ehllo
  # hi
  def anagram_grouping(array)
    # Init hash with arrays
    hash = Hash.new{|h, k| h[k] = []}

    array.each do |e|
      sorted = e.chars.sort*('')
      hash[sorted] << e
    end

    hash.each { |_,v| puts v; puts "\n" }
  end
end
