require 'minitest/autorun'
require './lib/day_fifteen'
class DayFifteenTest < MiniTest::Test
  def test_example
    day = DayFifteen.new(DayFifteen.example)
    assert_equal 5, day.find_drop
  end

  def test_input
    day = DayFifteen.new(DayFifteen.discs)
    assert_equal 203660, day.find_drop
  end

  def test_two
    day = DayFifteen.new(DayFifteen.two)
    assert_equal 2408135, day.find_drop
  end
end