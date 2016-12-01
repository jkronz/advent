input = %w(R1 R3 L2 L5 L2 L1 R3 L4 R2 L2 L4 R2 L1 R1 L2 R3 L1 L4 R2 L5 R3 R4 L1 R2 L1 R3 L4 R5 L4 L5 R5 L3 R2 L3 L3 R1 R3 L4 R2 R5 L4 R1 L1 L1 R5 L2 R1 L2 R188 L5 L3 R5 R1 L2 L4 R3 R5 L3 R3 R45 L4 R4 R72 R2 R3 L1 R1 L1 L1 R192 L1 L1 L1 L4 R1 L2 L5 L3 R5 L3 R3 L4 L3 R1 R4 L2 R2 R3 L5 R3 L1 R1 R4 L2 L3 R1 R3 L4 L3 L4 L2 L2 R1 R3 L5 L1 R4 R2 L4 L1 R3 R3 R1 L5 L2 R4 R4 R2 R1 R5 R5 L4 L1 R5 R3 R4 R5 R3 L1 L2 L4 R1 R4 R5 L2 L3 R4 L4 R2 L2 L4 L2 R5 R1 R4 R3 R5 L4 L4 L5 L5 R3 R4 L1 L3 R2 L2 R1 L3 L5 R5 R5 R3 L4 L2 R4 R5 R1 R4 L3)
# input = %w(R8 R4 R4 R8)
@coords = { x: 0, y: 0 }
@history = []
@current_direction = 'N'

def process_turn(turn)
  if @current_direction == 'N'
    turn == 'R' ? 'E' : 'W'
  elsif @current_direction == 'S'
    turn == 'R' ? 'W' : 'E'
  elsif @current_direction == 'E'
    turn == 'R' ? 'S' : 'N'
  elsif @current_direction == 'W'
    turn == 'R' ? 'N' : 'S'
  end
end

def process_steps(count)
  if @current_direction == 'N'
    sym = :y
    sign = :+
  elsif @current_direction == 'S'
    sym = :y
    sign = :-
  elsif @current_direction == 'E'
    sym = :x
    sign = :+
  elsif @current_direction == 'W'
    sym = :x
    sign = :-
  end
  count.abs.times do
    @coords[sym] = @coords[sym].send(sign, 1)
    new_loc = @coords.dup
    @history << new_loc
    puts "Crosses at #{new_loc}" if @history.uniq!
  end

end

input.each do |instruction|
  turn = instruction[0]
  steps = instruction[1..-1].to_i
  @current_direction = process_turn(turn)
  process_steps(steps)
end

puts @coords