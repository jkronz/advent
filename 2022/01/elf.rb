class Elf
  attr_accessor :calories

  def initialize
    self.calories = 0
  end

  def <=>(other)
    calories <=> other.calories
  end
  
  def to_s
    calories.to_s
  end
end

elves = []
current_elf = Elf.new
File.readlines('input.txt').each do |line|      
  if line.strip == ''    
    current_elf = Elf.new
    elves << current_elf
  else
    current_elf.calories += line.to_i
  end
end

puts elves.sort.last.calories
# puts elves.sort.map(:to_s)
puts elves.sort.last(3).sum(&:calories)