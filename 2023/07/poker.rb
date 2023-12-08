class Poker
  attr_reader :hands
  def initialize(file)
    lines = File.readlines(__dir__ + "/#{file}")
    @hands = lines.map { |str| Hand.new(str) }
  end

  def winnings
    @total_winnings = 0
    hands.sort.each_with_index do |hand, idx|
      rank = idx + 1
      @total_winnings += rank * hand.bid
    end
    @total_winnings
  end

  def with_wilds
    replacement_hands = hands.map(&:with_wilds)
    winnings = 0
    replacement_hands.sort.each_with_index do |hand, idx|
      rank = idx + 1
      winnings += rank * hand.bid
    end
    winnings
  end
end

class Hand
  attr_accessor :cards, :bid, :card_str
  def initialize(string)
    @card_str, @bid = string.split
    @cards = {}
    @bid = @bid.to_i
    @card_str.chars.each do |char|
      @cards[char] ||= 0
      @cards[char] += 1
    end
  end

  # 5oaK 7
  # 4oaK 6
  # FH   5
  # 3oaK 4
  # 2P   3
  # Pair 2
  # HC   1
  def type
    return @type if !@type.nil?
    return @type = 7 if @cards.values.any? { |count| count == 5 }
    return @type = 6 if @cards.values.any? { |count| count == 4 }
    if @cards.values.any? { |count| count == 3 }
      if @cards.values.any? { |count| count == 2 }
        return @type = 5
      else
        return @type = 4
      end
    end
    return 3 if @cards.values.count { |count| count == 2 } == 2
    return 2 if @cards.values.any? { |count| count == 2 }
    1
  end

  CARD_RANK = %w[A K Q T 9 8 7 6 5 4 3 2 J]
  def card_rank(card)
    CARD_RANK.index(card)
  end

  def with_wilds
    return self if @cards['J'].nil?
    replacement_hands = []
    jokers = @cards['J'].to_i
    CARD_RANK.each do |c|
      next if c == 'J'
      cards = @cards.dup
      cards[c] = cards[c].to_i + jokers
      cards['J'] = 0
      hand = WildHand.new(@card_str)
      hand.cards = cards
      hand.bid = bid
      replacement_hands << hand
    end
    replacement_hands.sort.last
  end

  def <=>(other_card)
    if type == other_card.type
      5.times do |idx|
        left = card_rank(card_str[idx])
        right = card_rank(other_card.card_str[idx])
        next if left == right
        return right <=> left
      end
    else
      type <=> other_card.type
    end
  end

  def to_s
    "#{@card_str} #{@bid} #{type}"
  end
end

class WildHand < Hand

  def initialize(string)
    @card_str = string
  end

  def to_s
    super + cards.to_s
  end
end

puts Poker.new("input.txt").with_wilds
#252215321
#252113488