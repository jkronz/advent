class Game
  attr_reader :id, :draws
  def initialize(line)
    game, draws = line.split(":")
    @id = game.split(' ')[1].to_i
    @draws = draws.split(";")
  end

  def maximums
    return @maximums if @maximums
    @maximums = {}
    draws.each do |draw|
      cubes = draw.split(",")
      cubes.each do |cube|
        count, color = cube.strip.split(' ')
        color = color.strip
        if @maximums[color].nil? || @maximums[color] < count.to_i
          @maximums[color] = count.to_i
        end
      end
    end
    @maximums
  end

  def to_s
    ["Game #{id}", "Power #{power}", maximums.to_s].join("\n")
  end

  def valid?(rules)
    maximums.each do |key, val|
      return 0 if rules[key].to_i < val
    end
    id
  end

  def power
    p = 1
    maximums.each do |_k, v|
      p = p * v
    end
    p
  end
end

lines = File.readlines(__dir__ + '/input.txt')

s = lines.sum do |line|
  game = Game.new(line)
  # game.valid?({'red' => 12, 'green' => 13, 'blue' => 14})
  game.power
end

puts s
