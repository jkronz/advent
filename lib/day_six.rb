require 'input_reader'
class DaySix
  include InputReader

  def initialize(file)
    @data = read_rows(file).map { |row| row.gsub(/\s/, '') }
  end

  def count(reverse = true)
    obj = (0...@data.first.length).map { |_| {} }
    counts = @data.each_with_object(obj) do |row, accum|
      row.chars.each_with_index do |char, idx|
        accum[idx][char] = accum[idx][char].to_i + 1
      end
    end

    counts = counts.map do |ha|
      ha.sort_by do |k, v|
        if reverse
          -v
        else
          v
        end
      end.first
    end
    counts.map(&:first).join
  end
end
