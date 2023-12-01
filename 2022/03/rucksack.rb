class Rucksack
  attr_accessor :left, :right
  
  def initialize(line)
    pivot = line.length / 2
    self.left = line[0..pivot-1]
    self.right = line[pivot..-1]
  end

  def to_s
    "#{left} #{right}"
  end

  def common_item
    (left.chars & right.chars).first
  end

  SCORING = ['*'] + ('a'..'z').to_a + ('A'..'Z').to_a
  def score
    SCORING.find_index(common_item)
  end
end

puts Rucksack.new('vJrwpWtwJgWrhcsFMMfFFhFp').score

total = 0
File.readlines('input.txt').each do |line|
  total += Rucksack.new(line).score
end

puts total
total = 0
SCORING = ['*'] + ('a'..'z').to_a + ('A'..'Z').to_a
File.readlines('input.txt').each_slice(3) do |group|
  common = (group[0].chars & group[1].chars & group[2].chars).first
  total += SCORING.find_index(common)
end

puts total