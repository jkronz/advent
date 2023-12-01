class Cpu
  attr_accessor :cycle, :x

  def initialize(program)
    @lines = File.readlines(program).to_a
    @cycle = 0
    @x = 1
  end

  def run
    @lines.each do |line|
      if line.start_with?('addx')
        addend = line.split(' ')[1].to_i        
        advance_clock
        advance_clock
        self.x += addend
      elsif line == 'noop'
        advance_clock
      end
    end
  end

  def advance_clock
    new_cycle = cycle + 1
    puts "#{new_cycle} #{x} = #{signal_strength}" if cycle % 20 == 0
    self.cycle = new_cycle        
  end

  def signal_strength
    cycle * x
  end

end

Cpu.new('test_input.txt').run