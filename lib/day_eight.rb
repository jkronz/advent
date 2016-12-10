require 'input_reader'
class DayEight
  include InputReader

  attr_accessor :display

  def initialize(rows = 6, cols = 50)
    @display = []
    rows.times do |row|
      @display[row] = []
      cols.times { @display[row] << '.' }
    end
  end

  def apply_instructions(file='input/day_eight.txt')
    read_rows(file).map do |line|
      if line.start_with?('rect')
        args = line.gsub('rect', '').strip.split('x').map(&:to_i)
        fill(*args)
      elsif line.start_with?('rotate row')
        line = line.gsub('rotate row y=', '')
        args = line.split('by').map { |arg| arg.strip.to_i }
        rotate_y(*args)
      else
        line = line.gsub('rotate column x=', '')
        args = line.split('by').map { |arg| arg.strip.to_i }
        rotate_x(*args)
      end
    end
    @display
  end

  def count_lights
    @display.reduce(0) do |accum, row|
      accum = accum + row.count { |c| c == '#' }
      accum
    end
  end

  def fill(wide, high)
    high.times do |i|
      wide.times { |j| @display[i][j] = '#' }
    end
    @display
  end

  def rotate_x(column, count)
    current_values = @display.map { |row| row[column] }
    current_values = current_values.rotate(-count)
    (0...@display.length).each do |i|
      @display[i][column] = current_values[i]
    end
    @display
  end

  def rotate_y(row, count)
    @display[row] = @display[row].rotate(-count)
    @display
  end

  def display_out
    puts '=' * 50
    @display.each do |row|
      puts row.join
    end
    puts '=' * 50
  end
end