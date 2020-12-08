class Instruction
  PARSER = /(\w{3}) \+?(\-?\d+)/

  attr_accessor :op, :arg, :dirty

  def initialize(line)
    match_data = PARSER.match(line)
    self.op = match_data[1]
    self.arg = match_data[2].to_i
    self.dirty = false
  end

  def to_s
    "#{op} #{arg}"
  end

  def clone
    obj = super
    obj.op = op
    obj.arg = arg
    obj.dirty = false
    obj
  end
end

class Processor
  def initialize(file)
    lines = File.readlines(file, chomp: true)
    @instructions = lines.map { |l| Instruction.new(l) }
  end

  def process(instructions: @instructions, eject: false)
    accumulator = 0
    idx = 0
    loop do
      current = instructions[idx]

      break if current.nil? || !eject && current.dirty
      return -1 if eject && current.dirty

      current.dirty = true

      case current.op
      when 'nop'
        idx += 1
      when 'acc'
        idx += 1
        accumulator += current.arg
      when 'jmp'
        idx += current.arg
      end

    end

    accumulator
  end

  def fix
    @instructions.each_with_index do |ins, idx|
      if ins.op == 'nop'
        temp = clone_instructions
        temp[idx].op = 'jmp'
        result = process(eject: true, instructions: temp)
        return result if result.positive?
      elsif ins.op == 'jmp'
        temp = clone_instructions
        temp[idx].op = 'nop'
        result = process(eject: true, instructions: temp)
        return result if result.positive?
      end
    end
    false
  end

  def clone_instructions
    @instructions.map(&:clone)
  end
end

puts Processor.new('input.txt').process
puts Processor.new('input.txt').fix
