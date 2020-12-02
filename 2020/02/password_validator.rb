class Password
  LINE_PARSER = /(\d+)-(\d+) ([a-zA-Z]): ([a-zA-Z]+)/.freeze

  def initialize(line)
    @match_data = LINE_PARSER.match(line).to_a
  end

  def min
    @match_data[1].to_i
  end

  def max
    @match_data[2].to_i
  end

  def character
    @match_data[3]
  end

  def password
    @match_data[4]
  end

  def valid?
    found_count = password.chars.count { |c| c == character }
    found_count >= min && found_count <= max
  end

  def valid_p2?
    (password.chars[min - 1] == character) ^ (password.chars[max - 1] == character)
  end
end

class PasswordList
  def initialize(file)
    @lines = File.readlines(file)
  end

  def valid_passwords
    @lines.count do |line|
      pw = Password.new(line)
      pw.valid?
    end
  end

  def valid_passwords_p2
    @lines.count do |line|
      pw = Password.new(line)
      pw.valid_p2?
    end
  end
end

puts PasswordList.new('input.txt').valid_passwords
puts PasswordList.new('input.txt').valid_passwords_p2
