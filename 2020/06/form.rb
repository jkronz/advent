class CustomsFormGroup
  def initialize(line_group)
    @people = line_group.split("\n").map { |s| s.gsub(/\s/, '') }
  end

  def unique_responses
    @people.join('').chars.uniq.count
  end

  def unanimous_responses
    @people.reduce(('a'..'z').to_a) do |accum, person|
      accum & person.chars
    end.count
  end
end

class Processor
  attr_reader :groups

  def initialize(file)
    line_groups = File.read(file).split("\n\n")
    @groups = line_groups.map { |l| CustomsFormGroup.new(l) }
  end
end

puts Processor.new('input.txt').groups.sum(&:unique_responses)
puts Processor.new('input.txt').groups.sum(&:unanimous_responses)
