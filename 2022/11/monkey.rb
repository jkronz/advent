class Monkey
  attr_reader :test, :operation, :items, :id, :true_target, :false_target, :inspections

  def initialize(id)
    @id = id
    @inspections = 0
  end

  ITEMS_PARSER = /\s*Starting items: ([\d+|\s|,]+)$/
  def items=(line)
    match_data = ITEMS_PARSER.match(line) or return
    @items = match_data[1].split(',').map(&:to_i)
  end

  OPERATION_PARSER = /\s*Operation: new = ((old|\*|\+|\d+) (old|\*|\+|\d+) (old|\*|\+|\d+))/
  def operation=(line)
    match_data = OPERATION_PARSER.match(line) or return
    @operation = Proc.new { |old| eval(match_data[1]) }
  end

  TEST_PARSER = /\s*Test: divisible by (\d+)/
  def test=(line)
    match_data = TEST_PARSER.match(line) or return
    @test = Proc.new { |nerve_score| (nerve_score % match_data[1].to_i) == 0 }    
  end

  TRUE_TARGET_PARSER = /\s*If true: throw to monkey (\d+)/
  def true_target=(line)
    match_data = TRUE_TARGET_PARSER.match(line) or return
    @true_target = match_data[1].to_i
  end

  FALSE_TARGET_PARSER = /\s*If false: throw to monkey (\d+)/
  def false_target=(line)
    match_data = FALSE_TARGET_PARSER.match(line) or return
    @false_target = match_data[1].to_i
  end

  def analyze_all
    results = []
    loop do
      return results if items.empty?
      results << analyze
    end
  end

  def analyze
    # puts items.to_s
    @current_item = items.shift
    # puts "old score= #{@current_item}"
    nerve_score = operation.call(@current_item)
    # puts "new score= #{nerve_score}"
    nerve_score = nerve_score % 9699690
    # puts "bored_score= #{nerve_score}"
    interesting = test.call(nerve_score)
    # puts "interesting= #{interesting}"
    target = interesting ? true_target : false_target
    # puts "target= #{target}"
    @inspections += 1
    [nerve_score, target]
  end
  
  def pretty_print
    puts "ID: #{id}, items: #{items.join(',')}, true: #{true_target}, false: #{false_target}"
  end

  def <=>(other)
    @inspections <=> other.inspections
  end
end

monkeys = []

File.readlines('input.txt').each do |line|
  if line.start_with?('Monkey')
    monkeys << Monkey.new(monkeys.size)
  else
    monkeys.last.items = line
    monkeys.last.operation = line
    monkeys.last.test = line
    monkeys.last.true_target = line
    monkeys.last.false_target = line    
  end
end


10_000.times do |i|
  puts i
  monkeys.each do |monkey|
    shares = monkey.analyze_all
    shares.each do |score, target|
      monkeys[target].items << score
    end
  end  
end
monkeys.map(&:pretty_print)

puts monkeys.sort.last(2).map(&:inspections)