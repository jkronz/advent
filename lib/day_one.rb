class DayOne
  def initialize
    @coords = { x: 0, y: 0 }
    @history = []
    @current_direction = 'N'
  end

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

  def process_steps(count, break_on_duplicate=false)
    if @current_direction == 'N'
      sym = :y
      sign = :+
    elsif @current_direction == 'S'
      sym = :y
      sign = :-
    elsif @current_direction == 'E'
      sym = :x
      sign = :+
    else
      sym = :x
      sign = :-
    end
    count.abs.times do
      @coords[sym] = @coords[sym].send(sign, 1)
      new_loc = @coords.dup
      @history << new_loc
      return new_loc if break_on_duplicate && @history.uniq!
    end
    @coords
  end

  def process_part_one(input)
    input.each do |instruction|
      turn = instruction[0]
      steps = instruction[1..-1].to_i
      @current_direction = process_turn(turn)
      process_steps(steps)
    end
    @coords[:x].abs + @coords[:y].abs
  end

  def process_part_two(input)
    input.each do |instruction|
      turn = instruction[0]
      steps = instruction[1..-1].to_i
      @current_direction = process_turn(turn)
      process_steps(steps, true)
    end
    @coords[:x].abs + @coords[:y].abs
  end
end