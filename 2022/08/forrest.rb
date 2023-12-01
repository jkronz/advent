class Tree
  attr_accessor :height, :visible, :x, :y

  def initialize(height)
    @height = height
  end
  
  def to_s
    if visible 
      height
    else 
      '*'
    end
  end
end

class Forrest
  attr_accessor :trees

  def initialize 
    self.trees = []
  end

  def add_row(line)
    self.trees << line.strip.chars.map do |height|
      Tree.new(height.to_i)
    end
  end

  def visible_count
    rows = trees.length
    columns = trees[0].length
    rows.times do |y|
      columns.times do |x|        
        visible = visible_from_east?(x, y) ||
          visible_from_north?(x, y) ||
          visible_from_south?(x, y) ||
          visible_from_west?(x, y)
        puts "#{[x, y].to_s}, #{trees[y][x].height}" if visible
        trees[y][x].visible = visible
      end
    end
    trees.flatten.count { |tree| tree.visible }
  end

  def pretty_print
    trees.each do |row|
      puts row.map(&:to_s).join
    end
  end

  private

  def visible_from_north?(x, y)
    return true if y == 0 # all the top row is visible
    max = trees[y][x].height
    heights = (0...y).to_a.all? do |i|
      trees[i][x].height < max
    end
  end
  
  def visible_from_east?(x, y)
    right_border = trees[0].length - 1
    return true if x == right_border # all on right border are visible
    max = trees[y][x].height
    heights = (x+1..right_border).to_a.all? do |i|
      trees[y][i].height < max
    end
  end

  def visible_from_south?(x, y)
    bottom_border = trees.length - 1
    return true if x == bottom_border # all on right border are visible
    max = trees[y][x].height
    heights = (y+1..bottom_border).to_a.all? do |i|
      trees[i][x].height < max
    end
  end

  def visible_from_west?(x, y)    
    return true if x == 0 # all on right border are visible
    max = trees[y][x].height
    heights = (0...x).to_a.all? do |i|
      trees[y][i].height < max
    end
  end

  
end

forrest = Forrest.new
File.readlines('input.txt').each do |line|
  forrest.add_row(line)
end
puts forrest.visible_count
forrest.pretty_print