class AdapterSet
  def initialize(file)
    @adapter_joltages = File.readlines(file).map(&:to_i).sort
    @adapter_joltages.unshift(0)
    @end = @adapter_joltages.last
  end

  def differences
    result = [0, 0, 1]
    @adapter_joltages.each_index do |idx|
      next if idx + 1 == @adapter_joltages.count

      diff = @adapter_joltages[idx + 1] - @adapter_joltages[idx]
      result[diff - 1] += 1
    end
    result
  end

  def count_subchains(current = 0, accum = {})
    return accum[current] unless accum[current].nil?
    return 1 if current == @end

    left = @adapter_joltages.include?(current + 1) ? count_subchains(current + 1, accum) : 0
    middle = @adapter_joltages.include?(current + 2) ? count_subchains(current + 2, accum) : 0
    right = @adapter_joltages.include?(current + 3) ? count_subchains(current + 3, accum) : 0
    accum[current] = left + middle + right
  end
end

ary = AdapterSet.new('input.txt').differences
puts ary.first * ary.last
puts AdapterSet.new('input.txt').count_subchains
