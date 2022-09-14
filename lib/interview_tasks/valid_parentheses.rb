# Given a string containing just the characters () {} []
# determine if all opening/closing brackets match
# @example
# {{}}[()]() valid
# [} invalid
# (){ invalid


# Data structure - stack LIFO
def validation(string)
  stack = []
  string.chars.each do |c|
    case c
    when "{", "(", "["
      stack.push(c)
    when "}", ")", "]"
      return false if stack.empty?
      prev = stack.pop
      return false if !match(prev, c)
    end
  end
  return false if !stack.empty?
  true
end


def match(r, l)
  return true if r == "(" && l == ")"
  return true if r == "{" && l == "}"
  return true if r == "[" && l == "]"
  false
end

if validation "{[]}{}(){()[]}"
  puts "ok"
else
  puts "not ok"
end


if validation "{[{]}}"
  puts "ok"
else
  puts "not ok"
end