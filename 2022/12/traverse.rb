# Sabqponm  a b c c c d e f g h i j k l m n o p q r s t u v E
# abcryxxl
# accszExk
# acctuvwj
# abdefghi

# v..v<<<<
# >v.vv<<^
# .>vv>E^^
# ..v>>>^^
# ..>>>>>^

class Node
  attr_accessor :visited, :elevation, :distance, :x, :y

  def initialize(x, y, elevation)
    @x = x
    @y = y
    @elevation = elevation
    visited = false
  end
  
  def finish?
    elevation == 'E'
  end

  def distance=(new_distance)
    if @distance.nil? || new_distance < @distance
      @distance = new_distance    
    end
  end
    
  def price
    return 27 if elevation == 'S' # cost to move away from start is always negative
    return 26 if elevation == 'E' # cost to move to end is always negative
    ('a'..'z').to_a.index(elevation)
  end

  def vertices(map)
    [left(map), right(map), up(map), down(map)].compact
  end

  def left(map)
    return nil if x == 0
    point_b = map[y][x - 1]
    cost = point_b.price - price
    return nil if cost > 1
    Vertex.new(self, point_b, 1)
  end

  def right(map)
    max_right = map[y].length - 1
    return nil if x == max_right
    point_b = map[y][x + 1]
    cost = point_b.price - price
    return nil if cost > 1
    Vertex.new(self, point_b, 1)
  end

  def up(map)
    return nil if y == 0
    point_b = map[y - 1][x]
    cost = point_b.price - price
    return nil if cost > 1
    Vertex.new(self, point_b, 1)
  end

  def down(map)
    max_down = map.length - 1
    return nil if y == max_down
    point_b = map[y + 1][x]
    cost = point_b.price - price
    return nil if cost > 1
    Vertex.new(self, point_b, 1)
  end

  def to_s    
    "#{x},#{y}: #{elevation}, #{distance}"
  end
end

class Vertex
  attr_accessor :point_a, :point_b, :distance  
  def initialize(point_a, point_b, distance)
    @point_a = point_a
    @point_b = point_b
    @distance = distance
  end
end

map = []
queue = []
File.readlines('input.txt').each_with_index do |line, y|
  line.strip.chars.each_with_index do |elevation, x|
    map[y] ||= [] 
    map[y][x] = Node.new(x, y, elevation)
    if elevation == 'a'      
      start_node = map[y][x] # set start node
      start_node.distance = 0
      queue << start_node
    end
  end
end

current_node = nil
loop do
  current_node = queue.shift
  next if current_node.visited
  current_node.visited = true
  break if current_node.finish?
  current_node.vertices(map).each do |vertex|
    vertex.point_b.distance = current_node.distance + vertex.distance
    queue << vertex.point_b if !vertex.point_b.visited
  end  
end  

puts current_node.distance
