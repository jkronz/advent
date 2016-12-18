require 'minitest/autorun'
require './lib/day_thirteen'
class DayThirteenTest < MiniTest::Test

  def test_default
    day = DayThirteen.new(10, 0, 0)
    assert_equal day.shortest_path, 0
  end

  def test_example
    day = DayThirteen.new(10, 7, 4)
    assert_equal 11, day.shortest_path
    day = DayThirteen.new(10, 1, 2)
    assert_equal 1, day.shortest_path
  end

  def test_input
    day = DayThirteen.new(1352, 31, 39)
    assert_equal 90, day.shortest_path
  end

  def test_limit
    day = DayThirteen.new(10, 7, 4)
    assert_equal 9, day.reachable(4)
    assert_equal 19, day.reachable
    day = DayThirteen.new(1352, 31, 39)
    assert_equal 135, day.reachable
  end
end
