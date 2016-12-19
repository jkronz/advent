require 'minitest/autorun'
require './lib/day_eighteen'
class DayEighteenTest < MiniTest::Test
  def test_example
    day = DayEighteen.new(DayEighteen.example)
    assert_equal 38, day.count_safes(10)
  end

  def test_input
    day = DayEighteen.new
    assert_equal 1961, day.count_safes(40)
  end

  def test_part_two
    day = DayEighteen.new
    assert_equal 20_000_795, day.count_safes(400000)
  end

end