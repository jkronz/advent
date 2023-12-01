
stacks = {
  1 => %w(G P N R),
  2 => %w(H V S C L B J T),
  3 => %w(L N M B D T),
  4 => %w(B S P V R),
  5 => %w(H V M W S Q C G),
  6 => %w(J B D C S Q W),
  7 => %w(L Q F),
  8 => %w(V F L D T H M W),
  9 => %w(F J M V B P L)
}

# stacks = {
#   1 => %w(N Z),
#   2 => %w(D C M),
#   3 => %w(P)
# }

class Instruction
  attr_accessor :count, :source, :destination

  PARSER = /move\s(\d+)\sfrom\s(\d+)\sto\s(\d+)/.freeze

  def initialize(line)
    match_data = PARSER.match(line)
    self.count = match_data[1].to_i
    self.source = match_data[2].to_i
    self.destination = match_data[3].to_i
  end

  def to_s
    "Move: #{count}, Src: #{source}, Dest: #{destination}"
  end
end

instructions = File.readlines('input.txt').map { |line| Instruction.new(line) }
# instructions = [Instruction.new('move 1 from 2 to 1')]
  # Instruction.new('move 3 from 1 to 3')]
puts stacks.values.to_s
instructions.each do |instruction|
  source = stacks[instruction.source]
  destination = stacks[instruction.destination]  
  destination.unshift(*source.shift(instruction.count))
end

puts stacks.values.map(&:first).join.to_s
# puts stacks.values.to_s
