class BoatRace
  attr_reader :max_time, :midpoint, :record

  def initialize(time, record)
    @max_time = time
    @midpoint = time / 2
    @record = record
  end

  def find_left
    left = 0
    right = midpoint
    while left <= right
      m = ((left + right) / 2).floor
      if distance(m) > record # found winner, search lower
        @low_win = m if @low_win.nil? || @low_win > m
        right = m - 1
      else
        left = m + 1
      end
    end
    @low_win
  end

  def find_right
    left = midpoint
    right = max_time

    while left <= right
      m = ((left + right) / 2).floor
      if distance(m) > record # found winner, search higher
        @high_win = m if @high_win.nil? || m > @high_win
        left = m + 1
      else
        right = m - 1
      end
    end
    @high_win
  end

  def distance(charge_time)
    speed = charge_time
    race_time = @max_time - charge_time
    speed * race_time
  end

  def range
    left = find_left
    right = find_right
    right - left + 1
  end
end


# Time:        55     99     97     93
# Distance:   401   1485   2274   1405
#           9-46   25-74  42-55  23-69
combinations = 1
{ 55999793 => 401148522741405 }.each do |t, r|
  combinations *= BoatRace.new(t, r).range
end

puts combinations
