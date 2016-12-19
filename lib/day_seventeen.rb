require 'digest'
class DaySeventeen

  def initialize(passcode)
    @passcode = passcode
    @move_queue = [Room.new(nil, 0, 0, passcode)]
  end

  def find_path
    current = @move_queue.shift
    until current.goal?
      @move_queue << current.next_moves
      @move_queue.flatten!
      current = @move_queue.shift
    end
    current
  end

  def path
    find_path.password.gsub(@passcode, '')
  end

  def find_long_path
    current = @move_queue.shift
    all_paths = []
    until current.nil?
      if current.goal?
        all_paths << current
      else
        @move_queue << current.next_moves(true)
        @move_queue.flatten!
      end
      current = @move_queue.shift
    end
    all_paths.sort_by! { |node| node.password.length }
    all_paths.last.password.gsub(@passcode, '').length
  end

  class Room
    UNLOCKED = %w(b c d e f).freeze

    attr_accessor :password
    def initialize(parent, x, y, password)
      @x = x
      @y = y
      @parent = parent
      @password = password
      @hash = Digest::MD5.hexdigest(password)
    end

    def up?
      UNLOCKED.any? { |c| c == @hash[0] } && @y != 0
    end

    def down?
      UNLOCKED.any? { |c| c == @hash[1] } && @y != 3
    end

    def left?
      UNLOCKED.any? { |c| c == @hash[2] } && @x != 0
    end

    def right?
      UNLOCKED.any? { |c| c == @hash[3] } && @x != 3
    end

    def goal?
      @x == 3 && @y == 3
    end

    def next_moves(long = false)
      rooms = []
      if right?
        # if !long || @x + 1 != 3 || @y != 3
          rooms << Room.new(self, @x + 1, @y, "#{@password}R")
        # end
      end
      if down?
        # if !long || @x != 3 || @y + 1 != 3
          rooms << Room.new(self, @x, @y + 1, "#{@password}D")
        # end
      end
      if up?
        rooms << Room.new(self, @x, @y - 1, "#{@password}U")
      end
      if left?
        rooms << Room.new(self, @x - 1, @y, "#{@password}L")
      end
      rooms
    end
  end
end