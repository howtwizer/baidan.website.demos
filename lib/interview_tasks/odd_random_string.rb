module InterviewTasks
  # Random string with odd number of characters
  def odd_random_string(range = 10000)
    result = []
    random_string_length = rand(range)
    # be sure that odd
    random_string_length += 1 if random_string_length%2 == 0
    (1..random_string_length).each{ result << ('a'..'z').to_a[rand(26)] }
    result*('')
  end
end
