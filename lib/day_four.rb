require 'input_reader'
class DayFour
  include InputReader
  PARSER = /([a-z,-]+)-(\d{3})\[([a-z]{5})\]/.freeze
  ALPHABET = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z).freeze

  def initialize
    @rooms = read_rows('input/day_four.txt').map do |line|
      parse(line)
    end
  end

  def process_input(part_two = false)
    valid_rooms = @rooms.select do |room|
      room[:checksum] == expected_checksum(room[:name])
    end
    valid_rooms.each { |room| puts "#{decrypted_name(room)} #{room[:sector]}"} if part_two
    valid_rooms.reduce(0) { |accum, room| accum + room[:sector] }
  end

  def parse(line)
    match_data = PARSER.match(line)
    {
      name: match_data[1],
      sector: match_data[2].to_i,
      checksum: match_data[3]
    }
  end

  def decrypted_name(room)
    rotate_by = room[:sector] % ALPHABET.count
    chars = room[:name].chars.map do |character|
      if character == '-'
        ' '
      else
        current_index = ALPHABET.find_index(character) + rotate_by
        current_index -= ALPHABET.count if current_index >= ALPHABET.count
        ALPHABET[current_index]
      end
    end
    chars.join
  end

  def expected_checksum(name)
    name = name.gsub('-', '')
    char_counts = name.chars.each_with_object({}) do |char, accum|
      accum[char] = accum[char].to_i + 1
    end
    char_counts = char_counts.sort_by { |key, value| [value * -1, key] }
    char_counts.first(5).map { |char| char[0] }.join
  end
end