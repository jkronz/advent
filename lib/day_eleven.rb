require 'tree'
class DayEleven
  attr_accessor :step_tree

  def initialize
    @node_name = 0
    first_state = { floor: 0, state: [['A', 'a', 'F', 'f', 'G', 'g'],
                                      ['B', 'C', 'D', 'E'],
                                      ['b', 'c', 'd', 'e'],
                                      []] }
    # first_state = { floor: 0, state: [['A', 'a'],
    #                                   ['B', 'C', 'D', 'E'],
    #                                   ['b', 'c', 'd', 'e'],
    #                                   []] }

    @history_set = Set.new
    @search_set = Set.new
    @step_tree = Tree::TreeNode.new(first_state.to_s, first_state)
    @node_queue = []
    @node_queue << @step_tree
  end

  def build_tree
    current_node = @node_queue.shift
    until current_node.nil?
      moves = next_moves(current_node)
      # puts "Moves: #{moves.count}"
      moves.each do |next_move|
        name = next_move.to_s
        if complete?(next_move)
          # puts "COMPLETE"
          return current_node.add(Tree::TreeNode.new(name, next_move))
        elsif @history_set.add?(move_key(next_move))
          node = current_node.add(Tree::TreeNode.new(name, next_move))
          @node_queue << node
        end
      end
      current_node = @node_queue.shift
    end
  end

  def move_key(a)
    floors = a[:state].map do |floor|
      pairs = floor.uniq.count - floor.uniq { |t| t.downcase }.count
      singles = floor.uniq.count - pairs
      [pairs, singles]
    end
    floors << a[:floor]
    floors.join
  end

  def equal_move(a, b)
    move_key(a) == move_key(b)
  end

  def next_moves(leaf)
    next_moves = []
    current_state = leaf.content[:state]
    current_floor = leaf.content[:floor]
    possible_next_floors = if current_floor == 0
                             [1]
                           elsif current_floor == 3
                             [2]
                           elsif current_floor == 1 && current_state[0].empty?
                             [2]
                           elsif current_floor == 2 && current_state[0].empty? && current_state[1].empty?
                             [3]
                           else
                             [current_floor + 1, current_floor - 1]
                           end
    possible_next_floors.each do |new_floor|
      #test moving two items
      current_state[current_floor].combination(2) do |two_items|
        new_state = { floor: new_floor }
        new_state[:state] = current_state.dup
        new_state[:state][current_floor] = new_state[:state][current_floor] - two_items
        arr = (new_state[:state][new_floor] + two_items).sort_by! { |v| [v.downcase, v] }
        # puts "Arr: #{arr}"
        new_state[:state][new_floor] = arr
        if valid? new_state
          next_moves << new_state
        end
      end
      #test moving one item
      current_state[current_floor].combination(1) do |item|
        new_state = { floor: new_floor }
        new_state[:state] = current_state.dup
        new_state[:state][current_floor] = new_state[:state][current_floor] - item
        arr = (new_state[:state][new_floor] + item).sort_by! { |v| [v.downcase, v] }
        # puts "Arr: #{arr}"
        new_state[:state][new_floor] = arr
        if valid? new_state
          next_moves << new_state
        end
      end
    end
    next_moves
  end

  def complete?(game_state)
    game_state[:state][3].count == 14
  end

  def valid?(new_state)
    !new_state[:state].any? do |floor|
      gens = generators(floor)
      chips = chips(floor)
      gens.count > 0 && chips.count > 0 && (chips - gens.map(&:downcase)).count > 0
    end
  end

  CHIPS = /[a-z]/
  GENERATORS = /[A-Z]/

  def chips(floor)
    floor.select { |item| CHIPS =~ item }
  end

  def generators(floor)
    floor.select { |item| GENERATORS =~ item }
  end

end