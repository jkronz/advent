require 'pry'
class Computer
  def initialize(file)
    @program = File.readlines(file, chomp: true)
    @memory = {}
  end

  def execute
    @program.each do |line|
      instruction, argument = line.split('=').map(&:strip)
      if instruction == 'mask'
        @current_mask = Mask.new(argument)
      else
        address = instruction.gsub(/\D/, '').to_i
        @memory[address] = @current_mask.apply(argument.to_i)
      end
    end
    @memory.values.reduce(:+)
  end

  def execute_v2
    @program.each do |line|
      instruction, argument = line.split('=').map(&:strip)
      if instruction == 'mask'
        @current_mask = M2.new(argument)
      else
        address = instruction.gsub(/\D/, '').to_i
        @current_mask.apply(address).each do |addr|
          @memory[addr] = argument.to_i
        end
      end
    end
    @memory.values.reduce(:+)
  end
end

class Mask
  def initialize(mask_line)
    @mask = {}
    mask_line.chars.each_with_index do |char, idx|
      @mask[idx] = char if char != 'X'
    end
  end

  def apply(number)
    output = number.to_s(2).rjust(36, '0')
    @mask.each do |k, v|
      output[k] = v
    end
    output.to_i(2)
  end
end

class M2
  def initialize(mask_line)
    @mask = mask_line
  end

  def apply(number)
    addresses(xmask(number))
  end

  def addresses(xmask, accum = [''])
    return accum.map { |addr| addr.to_i(2) } if xmask.length == 0
    if xmask[0] != 'X'
      accum = accum.map do |address|
        address + xmask[0]
      end
    else
      accum = accum.map do |address|
        [address + '0', address + '1']
      end
    end
    addresses(xmask[1..-1], accum.flatten)
  end

  # this is a christmas pun get it?
  def xmask(number)
    n = number.to_s(2).rjust(36, '0')
    m = @mask.chars
    (0..36).map do |i|
      if m[i] == '0'
        n[i]
      else
        m[i]
      end
    end.join
  end
end

# puts Computer.new('input.txt').execute
# m2 = M2.new('000000000000000000000000000000X1001X')
# puts m2.xmask(42) # => 000000000000000000000000000000X1101X
# puts m2.apply(42) # => 26, 27, 58, 59

puts Computer.new('input.txt').execute_v2
