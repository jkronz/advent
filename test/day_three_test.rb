require 'minitest/autorun'
require './lib/day_three'
class DayThreeTest < MiniTest::Test

  def setup
  end

  def test_process_row
    assert_equal true, DayThree.new.process_row([14, 5, 10])
    assert_equal false, DayThree.new.process_row([15, 5, 10])
  end

  def test_part_one
    assert_equal 982, DayThree.new.process
  end

  def test_part_two
    assert_equal 1826, DayThree.new.process(true)
  end
end