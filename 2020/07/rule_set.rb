class Rule
  attr_reader :color, :children

  def initialize(rule_string)
    rule_string.gsub!(/\sbags?/, '').gsub!('.', '')
    @color, @child_string = rule_string.split('contain')
    @color = @color.strip
    @children = parse_children
  end

  CHILD_PARSER = /(\d+)\s(.+)$/.freeze

  def parse_children
    return [] if @child_string.include?('no other')
    children = @child_string.split(', ')
    @children = children.map do |child|
      match_data = CHILD_PARSER.match(child)
      { count: match_data[1].to_i, color: match_data[2] }
    end
  end
end

class RuleSet
  def initialize(file)
    @rules = File.readlines(file, chomp: true).map { |line| Rule.new(line) }
  end

  def search_up(color)
    bags = []
    queue = [color]
    loop do
      break if queue.empty?

      current_color = queue.pop
      @rules.each do |rule|
        if rule.children.any? { |child| child[:color] == current_color } && !bags.include?(rule.color)
          queue.push(rule.color)
          bags << rule.color
        end
      end
    end
    bags
  end

  def count_child_bags(color)
    rule = @rules.find { |r| r.color == color }
    return 0 if rule.children.empty?

    rule.children.reduce(0) do |accum, child|
      accum + (child[:count] + child[:count] * count_child_bags(child[:color]))
    end
  end
end

puts RuleSet.new('input.txt').search_up('shiny gold').count
puts RuleSet.new('input.txt').count_child_bags('shiny gold')
