class Ferry
  NAVIGATION_PARSER = /([A-Z])(\d+)/.freeze
  def initialize(file)
    @navigations = File.readlines(file, chomp: true).map do |line|
      match_data = NAVIGATION_PARSER.match(line)
      next unless match_data
      { direction: match_data[1], distance: match_data[2].to_i }
    end

    @heading = 90
    @x = 0
    @y = 0
    @wx = 10
    @wy = 1
  end

  def print_state
    puts "X:\t#{@x}\tY:\t #{@y}"
    puts "WX:\t#{@wx}\tWY:\t#{@wy}"
    puts "\n\n"
  end

  def navigate(via_waypoint: true)
    @navigations.each do |nav|
      if via_waypoint
        waypoint!(nav)
      else
        move!(nav)
      end
    end
    [@x, @y].to_s
  end

  def move!(instruction)
    case instruction[:direction]
    when 'N'
      @y += instruction[:distance]
    when 'S'
      @y -= instruction[:distance]
    when 'E'
      @x += instruction[:distance]
    when 'W'
      @x -= instruction[:distance]
    when 'L'
      @heading = (@heading - instruction[:distance]) % 360
    when 'R'
      @heading = (@heading + instruction[:distance]) % 360
    when 'F'
      move_forward!(instruction[:distance])
    end
  end

  def move_forward!(steps)
    case @heading
    when 0
      @y += steps
    when 90
      @x += steps
    when 180
      @y -= steps
    when 270
      @x -= steps
    else
      raise ArgumentError, 'unexpected heading'
    end
  end

  def waypoint!(instruction)
    case instruction[:direction]
    when 'N'
      @wy += instruction[:distance]
    when 'S'
      @wy -= instruction[:distance]
    when 'E'
      @wx += instruction[:distance]
    when 'W'
      @wx -= instruction[:distance]
    when 'R'
      deg = instruction[:distance]
      raise ArgumentError, "Weird R #{deg}" if ![90, 180, 270].include?(deg)
      (deg / 90).times { rotate_r }
    when 'L'
      deg = instruction[:distance]
      raise ArgumentError, "Weird L #{deg}" if ![90, 180, 270].include?(deg)
      (deg / 90).times { rotate_l }
    when 'F'
      all_ahead_full(instruction[:distance])
    end
  end

  def rotate_r
    new_y = -1 * @wx
    @wx = @wy
    @wy = new_y
  end

  def rotate_l
    new_x = -1 * @wy
    @wy = @wx
    @wx = new_x
  end

  def all_ahead_full(distance)
    x_distance = @wx * distance
    y_distance = @wy * distance
    @x += x_distance
    @y += y_distance
  end
end

puts Ferry.new('input.txt').navigate(via_waypoint: true)
