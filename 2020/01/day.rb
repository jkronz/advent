require 'set'

def format_input(file)
  File.readlines(file).map(&:to_i)
end

def find_two(input_array)
  check = Set.new
  input_array.each do |l|
    return [l, 2020 - l] if check.include?(2020 - l)
    check << l
  end
end

def find_three(input_array)
  input_array.each do |l|
    input_array.each do |m|
      input_array.each do |r|
        return [l, m, r] if (l + m + r) == 2020
      end
    end
  end
end

def part_one(input)
  lhs, rhs = find_two(format_input(input))
  lhs * rhs
end

def part_two(input)
  l, m, r = find_three(format_input(input))
  l * m * r
end

puts part_one('input.txt')
# 157059
puts part_two('input.txt')
# 165080960
