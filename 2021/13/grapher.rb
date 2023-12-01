class Grid
  attr_reader :grid, :width, :height

  def initialize(file)        
    lines = File.new(file).readlines
    @width = lines.map { |l| l.split(',')[0].to_i }.max + 1
    @height = lines.map { |l| l.split(',')[1].to_i }.max + 1 
    @grid = Array.new(@height) { Array.new(@width, '.') }
    lines.each do |row|
      x, y = row.split(',').map(&:to_i)
      @grid[y][x] = '#'
    end
  end

  def fold_up(line)
    (0...line).each do |row|
      (0...@width).each do |col|        
        @grid[row][col] = '#' if @grid[row][col] == '#' || @grid[@height - 1 - row][col] == '#'
      end
    end
    @grid = @grid[0...line]
    @height = line
    puts [line, @width, @height, @grid[0].length, @grid.length].to_s
  end

  def fold_left(line)
    (0...@height).each do |row|
      (0...line).each do |col|                
        @grid[row][col] = '#' if @grid[row][col] == '#' || @grid[row][@width - 1 - col] == '#'
      end
      @grid[row] = @grid[row][0...line] # trunc each line
    end 
    @width = line
    puts [line, @width, @height, @grid[0].length, @grid.length].to_s
  end

  def print_grid
    @grid.each do |row|
      puts row.join
    end
  end
end



grid = Grid.new('input.txt')
grid.fold_left(655)
grid.fold_up(447)
grid.fold_left(327)
grid.fold_up(223)
grid.fold_left(163)
grid.fold_up(111)
grid.fold_left(81)
grid.fold_up(55)
grid.fold_left(40)
grid.fold_up(27)
grid.fold_up(13)
grid.fold_up(6)
grid.print_grid
