require 'pry'
class BusSchedule
  def initialize(current_time, bus_id_str)
    @current_time = current_time
    @bus_ids = bus_id_str.split(',').map(&:to_i)
  end

  def next_bus
    time_check = @current_time
    loop do
      @bus_ids.each do |id|
        return [time_check - @current_time, id] if id.positive? && time_check % id == 0
      end
      time_check += 1
    end
    false
  end

  def bus_contest
    busses = @bus_ids.map.with_index do |id, idx|
      {id: id, index: idx} if id.positive?
    end.compact
    longest_route = busses.max_by { |bus| bus[:id] }

    interval = longest_route[:id]
    t = 0 - longest_route[:index]

    loop do
      t += interval
      busses.each do |bus|
        if (t + bus[:index]) % bus[:id] == 0
          interval = interval.lcm(bus[:id])
          busses.delete(bus)
        end
      end
      return t if busses.empty?
    end
  end

end

test = BusSchedule.new(939, "7,13,x,x,59,x,31,19")
puts test.bus_contest #=> 1068781
input = BusSchedule.new(1002460, "29,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,601,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,19,x,x,x,x,x,x,x,x,x,x,x,463,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37")
puts input.bus_contest
