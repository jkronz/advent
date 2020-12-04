class Passport

  def initialize(input, required_keys: [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid])
    key_pairs = input.split(/\s/)
    @data = key_pairs.reduce({}) do |accum, key_pair|
      key, value = key_pair.split(':')
      accum[key.to_sym] = value
      accum
    end
    @required_keys = required_keys
  end

  def valid?(strict: true)
    if strict
      missing_keys.count.zero? &&
        byr? &&
        iyr? &&
        eyr? &&
        hgt? &&
        hcl? &&
        ecl? &&
        pid?
    else
      missing_keys.count.zero?
    end
  end

  def missing_keys
    (@required_keys - @data.keys)
  end

  def byr?
    @data[:byr].to_i >= 1920 && @data[:byr].to_i <= 2002
  end

  def iyr?
    @data[:iyr].to_i >= 2010 && @data[:iyr].to_i <= 2020
  end

  def eyr?
    @data[:eyr].to_i >= 2020 && @data[:eyr].to_i <= 2030
  end

  def hgt?
    number = @data[:hgt].to_i
    if @data[:hgt].include?('cm')
      number >= 150 && number <= 193
    elsif @data[:hgt].include?('in')
      number >= 59 && number <= 76
    else
      false
    end
  end

  HCL = /^#([\da-f]{6})$/.freeze

  def hcl?
    HCL =~ @data[:hcl]
  end

  def ecl?
    %w[amb blu brn gry grn hzl oth].include?(@data[:ecl])
  end

  PID = /^\d{9}$/.freeze

  def pid?
    PID =~ @data[:pid]
  end
end

class Processor
  def initialize(file)
    @lines = File.readlines(file, chomp: true)
    data = []
    @passports = []
    @lines.each do |line|
      if line == ''
        @passports << Passport.new(data.join(' '))
        data = []
      else
        data << line
      end
    end
    @passports << Passport.new(data.join(' '))
  end

  def process_batch(strict: true)
    @passports.count { |passport| passport.valid?(strict: strict) }
  end
end

processor = Processor.new('input.txt')
puts processor.process_batch(strict: false)
puts processor.process_batch(strict: true)
