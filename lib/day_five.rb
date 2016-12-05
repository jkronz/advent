require 'digest'
class DayFive
  def initialize(key)
    @word = key
  end

  def find_password(length = 8, part_two = false)
    index = 0
    result = []
    valid_indices = (0...length).to_a
    found_chars = 0
    while found_chars < length
      if md5 = interesting_index?(index)
        if part_two
          key = md5[5]
          if result[key.to_i].nil? && valid_indices.find { |i| i.to_s == key }
            result[key.to_i] = md5[6]
            found_chars += 1
          end
        else
          result << md5[5]
          found_chars += 1
        end
      end
      index += 1
    end
    result.join
  end

  def interesting_index?(i)
    md5 = Digest::MD5.hexdigest("#{@word}#{i}")
    md5[0, 5] == '00000' ? md5 : nil
  end
end