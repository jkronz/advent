File.readlines('test_input.txt').each_slice(3) do |pair| # slice by 3 to clear newlines
  left = eval(pair[0])
  right = (pair[1])
  
  loop do
    left = Array(left)
    lf = left.first
    lr = left.try(:[], 1..-1)
    right = Array(right)
    rf = right.first
    rr = right.try(:[], 1..-1)

    puts "lf #{lf"
  end
end