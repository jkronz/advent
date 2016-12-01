require 'minitest/autorun'
require './lib/day_two'
class DayTwoTest < MiniTest::Test
  def setup
    @day = DayTwo.new
  end

  def test_part_one
    input = <<-INPUT
      ULL
      RRDDD
      LURDL
      UUUUD
    INPUT
    assert_equal '1985', @day.parse_input(input)
  end

  # def test_part_two
  #   assert_equal 4, @day.process_part_two(%w(R8, R4, R4, R8))
  # end
end
