require 'input_reader'
class DayTen
  include InputReader

  def initialize
    @output = []
    @bots = []
    @inputs = []
  end

  def build_bot_net(file='input/day_ten_sample.txt')
    read_rows(file).each do |instruction|
      if instruction.start_with?('bot')
        parse_bot(instruction)
      else
        parse_value(instruction)
      end
    end
  end

  VALUE_PARSER = /value (\d+) goes to (output|bot) (\d+)/

  def parse_value(instruction)
    match = VALUE_PARSER.match(instruction)
    @inputs << {
      value: match[1].to_i,
      value_target: match[2],
      value_address: match[3].to_i
    }
  end

  BOT_PARSE = /bot (\d+) gives low to (output|bot) (\d+) and high to (output|bot) (\d+)/.freeze

  def parse_bot(instruction)
    match = BOT_PARSE.match(instruction)
    @bots[match[1].to_i] = Bot.new({
                                     address: match[1].to_i,
                                     low_target: match[2],
                                     low_address: match[3].to_i,
                                     high_target: match[4],
                                     high_address: match[5].to_i
                                   })
  end

  def apply_values
    @inputs.each do |i|
      if i[:value_target] == 'output'
        @outputs[i[:value_address]] = i[:value]
      else
        @bots[i[:value_address]].process_input(i[:value], @bots, @output)
      end
    end
    # print_state
  end

  def print_state
    puts
    puts '=' * 50
    puts "Output: #{@output}"
    puts '=' * 50
    puts
  end

  class Bot
    def initialize(targets)
      @my_address = targets[:address]
      @low_target = targets[:low_target]
      @low_address = targets[:low_address]
      @high_target = targets[:high_target]
      @high_address = targets[:high_address]
      @values = []
    end

    def process_input(value, bots, output)
      @values << value
      if @values.length == 2
        @values.sort!
        # puts
        # puts "Bot #{@my_address} comparing values #{@values}"
        low_output(@values[0], bots, output)
        high_output(@values[1], bots, output)
      end
    end

    def low_output(value, bots, output)
      if @low_target == 'bot'
        bots[@low_address].process_input(value, bots, output)
      else
        output[@low_address] = value
      end
    end

    def high_output(value, bots, output)
      if @high_target == 'bot'
        bots[@high_address].process_input(value, bots, output)
      else
        output[@high_address] = value
      end
    end
  end

end