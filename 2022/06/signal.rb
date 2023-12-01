class DataStream
  attr_accessor :stream

  def initialize(stream)
    self.stream = stream
  end

  def marker
    stream.length.times do |idx|
      next if idx < 4
      range = (idx - 3)..idx
      if stream[range].chars.uniq.length == 4
        puts stream[range]
        return idx + 1 
      end
    end
  end
  
  def message
    stream.length.times do |idx|
      next if idx < 14
      range = (idx - 13)..idx
      if stream[range].chars.uniq.length == 14
        puts stream[range]
        return idx + 1 
      end
    end
  end
end

puts DataStream.new(File.readlines('input.txt').first).message