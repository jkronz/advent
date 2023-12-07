@max_time = 55999793
idx = 1
@goal = 401148522741405
left = nil
right = nil
def goal?(charge_time)
  speed = charge_time
  race_time = @max_time - charge_time
  (speed * race_time) > @goal
end

loop do
  if goal?(idx)
    left = idx
    idx += 1
    break
  end
  idx += 1
end

loop do
  if !goal?(idx)
    right = idx
    break
  end
  idx += 1
end

puts right - left + 1