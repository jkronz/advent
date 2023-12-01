class Valve
  attr_accessor :id, :flow_rate, :neighbor_ids, :open_at

  PARSER = /Valve\s([A-Z]{2})\shas\sflow\srate=(\d+);\stunnels?\sleads?\sto\svalves?\s(.+)$/
  def initialize(line)
    match_data = PARSER.match(line)    
    self.id, self.flow_rate, neighbors = match_data[1..-1]
    self.neighbor_ids = neighbors.split(', ').map { |s| s.strip }    
  end

  def to_s
    "#{id}: #{flow_rate}, neighbors: #{neighbor_ids}"
  end

  def to_h
    { flow_rate: flow_rate.to_i, neighbors: neighbor_ids }
  end
end

valves = {}
File.readlines('sample.txt').each do |line|
  line = line.strip
  next unless line.length > 0
  valve = Valve.new(line)
  valves[valve.id] = valve.to_h
end

def total_score(valves, t = 30, current_valve_id = 'AA', current_total = 0, open_valves = [], memo = {})
  return memo["#{current_valve_id}#{t}"] if memo["#{current_valve_id}#{t}"]
  if t.zero?
    # puts memo
    # puts "#{open_valves}: #{current_total}"

    return current_total
  end      
  valve = valves[current_valve_id]
  options = []
  if !open_valves.include?(current_valve_id) && valve[:flow_rate] > 0
    score = (t - 1) * valve[:flow_rate]
    new_open = open_valves.dup + [current_valve_id]
    options << total_score(valves, t - 1, current_valve_id, current_total + score, new_open, memo)
  end
  valve[:neighbors].each do |key|
    options << total_score(valves, t - 1, key, current_total, open_valves, memo)
  end
  memo["#{current_valve_id}#{t}"] = options.max
end

puts total_score(valves)


