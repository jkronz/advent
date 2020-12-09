require 'set'
class Cypher
  def initialize(file, lookback)
    @data = File.readlines(file, chomp: true).map(&:to_i)
    @lookback = lookback
  end

  def detect_error
    index = @lookback
    loop do
      target = @data[index]
      lookback_range = Set.new(@data[(index - @lookback)..index - 1])
      return target unless two_sum_exists?(target, lookback_range)
      index += 1
      break if index == @data.length
    end
  end

  def two_sum_exists?(target, search_set)
    search_set.each do |datum|
      operand = target - datum
      return true if datum != operand && search_set.include?(operand)
    end
    false
  end

  def find_contiguous_sum(target)
    current_sums = {}
    index = 0
    loop do
      current_sums[index] = []
      current_sums.each_key do |key|
        current_sums[key] << @data[index]
        return current_sums[key].sort if current_sums[key].sum == target && current_sums[key].length > 2

        current_sums.delete(key) if current_sums[key].sum > target
      end
      index += 1
      break if index == @data.length
    end
    false
  end
end


puts err = Cypher.new('john.txt', 125).detect_error
ary = Cypher.new('john.txt', 25).find_contiguous_sum(err)
puts ary.first + ary.last

