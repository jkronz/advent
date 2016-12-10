require 'input_reader'
class DaySeven
  include InputReader
  FORMAT = /\[([^\[\]]+)\]/.freeze
  POSITIVE = /[a-z]*([a-z]{1})([a-z]{1})(\2)(\1)[a-z]*/.freeze
  NEGATIVE = /\[[a-z]*([a-z]{1})([a-z]{1})(\2)(\1)[a-z]*\]/.freeze
  ABBA = /([a-z]{1})([a-z]{1})(\2)(\1)/.freeze

  def initialize
    @ips = read_rows('input/day_seven.txt').map do |line|
      format_ip(line)
    end
  end

  def format_ip(line)
    { hypers: line.scan(FORMAT).flatten, addresses: line.gsub(FORMAT, ' ').split }
  end

  def tls?(ip)
    address = ip[:addresses].find do |a|
      match = ABBA.match(a)
      match && match[1] != match[2]
    end
    hyper = ip[:hypers].find do |h|
      match = ABBA.match(h)
      match && match[1] != match[2]
    end
    !address.nil? && hyper.nil?
  end

  ABA = /(?=(.)(?:(?!\1)(.))(\1))/.freeze
  def ssl?(ip)
    abas = ip[:addresses].flat_map do |addr|
      addr.scan(ABA)
    end
    babs = abas.map do |aba|
      aba[1] + aba[0] + aba[1]
    end
    ip[:hypers].any? do |h|
      babs.any? { |bab| h.index(bab) }
    end
  end

  def count_tls
    @ips.count { |ip| tls?(ip) }
  end

  def count_ssl
    @ips.count { |ip| ssl?(ip) }
  end
end