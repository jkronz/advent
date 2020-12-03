class Forrest
  def initialize(forrest_lines, slope: { right: 3, down: 1 } )
    @forrest = forrest_lines.map { |s| s.gsub(/\s/, '') }
    @width = @forrest[0].length
    @d = 0
    @r = 0
    @slope = slope
  end

  def move!
    @d += @slope[:down]
    target_r = @r + @slope[:right]
    target_r -= @width if target_r >= @width
    @r = target_r
  end

  def tree?
    !@forrest[@d].nil? && @forrest[@d][@r] == '#'
  end

  def traverse!
    trees_encountered = 0
    @forrest.each do |row|
      move!
      trees_encountered += 1 if tree?
    end
    trees_encountered
  end
end

one = Forrest.new(File.readlines('input.txt'), slope: { right: 1, down: 1 }).traverse!
two = Forrest.new(File.readlines('input.txt'), slope: { right: 3, down: 1 }).traverse!
three = Forrest.new(File.readlines('input.txt'), slope: { right: 5, down: 1 }).traverse!
four = Forrest.new(File.readlines('input.txt'), slope: { right: 7, down: 1 }).traverse!
five = Forrest.new(File.readlines('input.txt'), slope: { right: 1, down: 2 }).traverse!
puts (one * two * three * four * five)
