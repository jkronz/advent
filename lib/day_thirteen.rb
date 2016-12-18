require 'tree'
class DayThirteen
  def initialize(modifier, *goal)
    @modifier = modifier
    @current_node = Position.new(nil, 1, 1, @modifier)
    @visited_nodes = []
    @move_queue = [@current_node]
    @goal = goal
  end

  def find_path(limit=nil)
    until @current_node.distance_to(*@goal) == 0 || @move_queue.empty?
      # current_state
      @move_queue = @move_queue.flatten
      @current_node = @move_queue.shift
      return if limit && @current_node.height > limit
      @visited_nodes << @current_node
      @move_queue << next_moves
    end
    @current_node
  end

  def current_state
    puts ''
    puts "Current State"
    puts "At: #{@current_node.to_s}"
    puts "Queue: #{@move_queue.flatten.map(&:to_s)}"
  end

  def shortest_path
    node = find_path
    node.height
  end

  def reachable(n = 50)
    find_path(n)
    visited = @visited_nodes.map(&:to_s).uniq
    visited.count
  end

  def next_moves
    current = @current_node
    right = Position.new(@current_node, current.x + 1, current.y, @modifier)
    down = Position.new(@current_node, current.x, current.y + 1, @modifier)
    up = Position.new(@current_node, current.x, current.y - 1, @modifier)
    left = Position.new(@current_node, current.x - 1, current.y, @modifier)
    new_moves = []
    new_moves << right if right.valid? && !right.visited?(@visited_nodes)
    new_moves << down if down.valid? && !down.visited?(@visited_nodes)
    new_moves << up if up.valid? && !up.visited?(@visited_nodes)
    new_moves << left if left.valid? && !left.visited?(@visited_nodes)
    new_moves.sort_by { |position| position.distance_to(*@goal) }
  end

  class Position
    attr_accessor :x, :y, :parent

    def initialize(parent, x, y, modifier)
      @parent = parent
      @x = x
      @y = y
      @modifier = modifier
    end

    def valid?
      return false if @x < 0 || @y < 0
      formula = @x*@x + 3*@x + 2*@x*@y + @y + @y*@y + @modifier
      formula.to_s(2).chars.count { |c| c == '1' }.even?
    end

    def height
      steps = []
      node = self
      until node.nil?
        steps << node
        node = node.parent
      end
      steps.count - 1
    end

    def distance_to(x, y)
      (x - @x).abs + (y - @y).abs
    end

    def visited?(history)
      history.any? { |old| old.to_s == to_s }
    end

    def to_s
      "#{@x},#{@y}"
    end
  end
end