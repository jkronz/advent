require 'input_reader'
class DayNine
  include InputReader

  def initialize
    @total = 0
  end

  def process
    process_string(File.open('input/day_nine.txt', 'r').read)
  end

  def process_string(str)
    output = []
    i = 0
    chars = str.chars
    while i < chars.length do
      if chars[i] == '('
        i = i + 1
        inst = ''
        while chars[i] != ')'
          inst << chars[i]
          i = i + 1
        end
        i = i + 1
        splt = inst.split('x')
        len = splt[0].to_i
        n = splt[1].to_i
        n.times { output << chars[i...(i+len)] }
        i += len
      else
        output << chars[i]
        i += 1
      end
    end
    output.join.length
  end

  def data_len(str)
    idx = str.index('(')
    total = 0
    until idx.nil?
      if idx > 0
        # chomp everything up to the next (
        total += idx
        str = str[idx..-1]
      else
        # expand the instruction, push the result back onto the string
        # and loop
        rparen = str.index(')')
        inst = str[1...rparen].split('x')
        len = inst[0].to_i
        time = inst[1].to_i
        dupe = str[(rparen+1), len]
        str = (dupe * (time - 1)) + str[(rparen+1)..-1]
      end
      idx = str.index('(')
    end
    total + str.length
  end

  # algo taken from the reddit thread that is fast
  def data_length(str)
    character_weight = [1] * str.length
    total = 0
    i = 0
    chars = str.chars
    while i < chars.length do
      inst = ''
      if chars[i] == '('
        i += 1
        while chars[i] != ')'
          inst << chars[i]
          i += 1
        end
        i += 1
        inst = inst.split('x')
        left = inst[0].to_i
        right = inst[1].to_i
        left.times do |t|
          character_weight[i + t] = character_weight[i + t] * right
        end
      else
        total += character_weight[i]
        i += 1
      end
    end

    total
  end
end
