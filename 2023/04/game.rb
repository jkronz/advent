class Game
  def initialize(file_name)
    lines = File.readlines(__dir__ + "/#{file_name}")
    @cards = lines.map { |line| Card.new(line) }
    @card_queue = {}
    @cards.each do |card|
      @card_queue[card.game_id] = { count: 1, card: card }
    end
  end

  def traverse
    (1..(@cards.length)).each do |idx|
      current_card = @card_queue[idx]
      match_count = current_card[:card].match_count
      ((idx + 1)..(idx + match_count)).each do |following_card|
        break if @card_queue[following_card].nil?
        @card_queue[following_card][:count] += current_card[:count]
      end
    end
    total = 0
    @card_queue.values.each do |hsh|
      total += hsh[:count]
    end
    total
  end

  def score
    @cards.sum(&:score)
  end
end

class Card
  attr_reader :game_id
  def initialize(line)
    game, numbers = line.split(':')
    @game_id = game.split[1].to_i
    @winning_numbers, @card_numbers = numbers.split('|')
    @winning_numbers = @winning_numbers.split.map(&:to_i)
    @card_numbers = @card_numbers.split.map(&:to_i)
  end

  def matches
    @matches ||= (@winning_numbers & @card_numbers)
  end

  def match_count
    @match_count ||= matches.length
  end
  def score
    return 0 if matches.empty?
    @score = 2 ** (matches.length - 1)
    @score
  end
end

# puts Game.new('input.txt').score
puts Game.new('input.txt').traverse