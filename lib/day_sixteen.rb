class DaySixteen
  def initialize(input, length)
    @length = length
    @data = input
  end

  def dragon(str)
    a = str
    b = a.reverse.chars.map { |c| c == '1' ? '0' : '1'}.join
    "#{a}0#{b}"
  end

  def fill
    while @data.length < @length
      @data = dragon(@data)
    end
    @data[0...@length]
  end

  def checksum(str)
    begin
      str = reduce_checksum(str)
    end until str.length.odd?
    str
  end

  def reduce_checksum(str)
    str.chars.each_slice(2).with_object([]) do |pair, accum|
      accum << (pair[0] == pair[1] ? '1' : '0')
    end.join
  end

  def fill_disk
    checksum(fill)
  end
end