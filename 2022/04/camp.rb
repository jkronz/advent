class CampRange < Range
  def overlaps?(other)
    (min <= other.min && max >= other.max) || (other.min <= min && other.max >= max)
  end  

  def subset_overlaps?(other)
    member?(other.min) || member?(other.max) || other.member?(min) || other.member?(max)
  end
end

count = 0

File.readlines('input.txt').each do |line|  
  left, right = line.split(',')
  left_min, left_max = left.split('-').map(&:to_i)
  right_min, right_max = right.split('-').map(&:to_i)
  left_range = CampRange.new(left_min, left_max)
  right_range = CampRange.new(right_min, right_max)
  if left_range.subset_overlaps?(right_range)
    count += 1 
    puts "#{left_range} #{right_range}"
  end
end

puts count