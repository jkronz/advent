require 'minitest/autorun'
require './lib/day_seventeen'
class DaySeventeenTest < MiniTest::Test

  def test_unlocked
    room = DaySeventeen::Room.new(nil, 0, 0, 'hijkl')
    assert_equal room.up?, false
    assert_equal room.down?, true
    assert_equal room.left?, false
    assert_equal room.right?, false
  end

  def test_example
    day = DaySeventeen.new('ihgpwlah')
    assert_equal 'DDRRRD', day.path
  end

  def test_input
    day = DaySeventeen.new('vwbaicqe')
    assert_equal 'DRDRULRDRD', day.path
  end

  def test_long
    day = DaySeventeen.new('ulqzkmiv')
    assert_equal 830, day.find_long_path
  end

  def test_part_two
    day = DaySeventeen.new('vwbaicqe')
    assert_equal 384, day.find_long_path
  end
end