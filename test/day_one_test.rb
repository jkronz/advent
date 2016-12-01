require 'minitest/autorun'
require './lib/day_one'
class DayOneTest < MiniTest::Test
  def setup
    @day = DayOne.new
  end

  def test_part_one
    @day = DayOne.new
    assert_equal 5, @day.process_part_one(%w(R2 L3))
  end

  def test_part_two
    @day = DayOne.new
    assert_equal 4, @day.process_part_two(%w(R8 R4 R4 R8))
  end
end
