require 'minitest/autorun'
require './lib/day_fourteen'
class DayFourteenTest < MiniTest::Test

  def test_example
    day = DayFourteen.new('abc')
    assert_equal 39, day.find_keys(1)
    assert_equal 22728, day.find_keys(64)
  end

  def test_input
    day = DayFourteen.new('cuanljph')
    assert_equal 23769, day.find_keys(64)
  end

  # def test_stretcher
  #   day = DayFourteen.new('abc')
  #   assert_equal 10, day.find_keys(1, :stretched_key)
  #   assert_equal 22551, day.find_keys(64, :stretched_key)
  # end

  def test_stretcher
    day = DayFourteen.new('cuanljph')
    assert_equal 22551, day.find_keys(64, :stretched_key)
  end

end
