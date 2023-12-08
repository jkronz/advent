
class Map
  attr_reader :location_map, :directions
  def initialize(filename)
    lines = File.readlines(__dir__ + "/#{filename}")
    @directions = lines[0].strip.chars
    nodes = lines[2..-1]
    @location_map = {}
    nodes.each do |line|
      loc = Location.new(line)
      @location_map.merge!(loc.to_h)
    end
    @start_nodes = @location_map.keys.select { |key| key.match(/\w\wA/) }
  end

  def traverse_all
    finish_times = @start_nodes.map do |key|
      traverse(key)
    end

    finish_times.reduce(1) do |accum, time|
      accum.lcm(time)
    end
  end

  def traverse(start_node, fuzzy = true)
    idx = 0
    current_node = start_node
    loop do
      return idx if current_node if complete?(current_node, fuzzy)
      direction = directions[idx % directions.length]
      current_node = location_map[current_node][direction]
      idx += 1
    end
  end

  private def complete?(key, fuzzy)
    if fuzzy
      key.match?(/\w\wZ/)
    else
      key == 'ZZZ'
    end
  end
end

class Location
  attr_reader :key, :left, :right
  def initialize(line)
    @key, dests = line.split('=')
    @key = @key.strip
    @left, @right = dests.split(',').map { |lr| lr.tr('() ', '').strip }
  end

  def to_h
    { key => { 'L' => left, 'R' => right } }
  end
end

puts Map.new('input.txt').traverse_all