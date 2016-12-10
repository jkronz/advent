require 'minitest/autorun'
require './lib/day_ten'
class DayTenTest < MiniTest::Test
  def test_example
    day = DayTen.new
    day.build_bot_net
    day.apply_values
  end

  def test_input
    day = DayTen.new
    day.build_bot_net('input/day_ten.txt')
    day.apply_values
  end
end