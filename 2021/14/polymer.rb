class PolymerChain
  attr_reader :rules, :chain

  def initialize(base_chain, rule_file)
    @chain = base_chain
    @rules = {}
    File.readlines(rule_file).each do |line|
      k, v = line.split('->').map(&:strip)      
      @rules[k] = v
    end
  end

  def build_chain(iterations = 10)
    iterations.times do |idx|        
      @chain = apply
      puts idx
    end
  end

  def apply2
    result = ""
    (0..chain.length-2).each do |idx|
      key = chain[idx..idx + 1]
      if value = rules[key]
        result += key[0] + value
      else
        result += key[0]
      end
    end
    result += chain[-1]
    result
  end

  def apply
    pairs = Hash.new(0)    
    # build the set of pairs
    (0..chain.length - 2).each do |idx|      
      key = chain[idx, 2]
      pairs[key] += 1
    end
    rules.each do |rule_key, rule_insert|
      if pairs[rule_key]
        pairs
      end
    end
    result.join + chain[-1]
  end

  def score
    character_hash = chain.chars.reduce({}) do |accum, char|
      accum[char] = accum[char].to_i + 1
      accum
    end
    sorted = character_hash.sort { |(ak, av), (bk, bv)| av <=> bv }  
    score = sorted[-1][1] - sorted[0][1]
    puts "Score: #{score}"
    score
  end

end

polymer = PolymerChain.new('CKFFSCFSCBCKBPBCSPKP', 'input.txt')                           
puts polymer.build_chain(40)
puts polymer.score == 3247