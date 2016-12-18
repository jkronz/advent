require 'digest'
class DayFourteen
  PENT = /(.)\1\1\1\1/.freeze
  TRIPLE = /(.)\1\1/.freeze
  def initialize(key = 'cuanljph')
    @index = 0
    @triples = []
    @valid_keys = []
    @key = key
    @search_index = 1000
  end

  def compute_hash(key_algo)
    hash = send(key_algo)
    str = hash
    pents = []
    until (match = PENT.match(str)).nil?
      pents << match[1] #get the first letter of the match
      str = str.gsub(match[0], '')
    end
    min_index = [0, @index - 1000].max
    max_index = @index
    pents.each do |k|
      @triples[min_index..max_index].each_with_index do |val, i|
        @valid_keys << {key: k, index: i + min_index} if k == val && !@valid_keys.any? { |valid_key| valid_key[:index] == i + min_index }
        @valid_keys.sort_by! { |key| key[:index] }
      end
    end
    str = hash
    unless (match = TRIPLE.match(str)).nil?
      @triples[@index] = match[1]
    end
  end

  def find_keys(n = 64, key_algo = :hash_key)
    while n > @valid_keys.count || possible_lower_triples?(n - 1)
      compute_hash(key_algo)
      @index += 1
    end
    @valid_keys = @valid_keys.sort_by! { |key| key[:index] }
    puts "#{@valid_keys.first(64)}"
    @valid_keys[n - 1][:index]
  end

  def possible_lower_triples?(n)
    min_index = [0, @index - 1000].max
    max_index = @valid_keys[n][:index]
    @triples[min_index...max_index].compact.any?
  end

  def hash_key
    Digest::MD5.hexdigest("#{@key}#{@index}")
  end

  def stretched_key()
    key = Digest::MD5.hexdigest("#{@key}#{@index}")
    2016.times do
      key = Digest::MD5.hexdigest(key)
    end
    key
  end
end
