require 'minitest/autorun'
require './lib/day_eight'
class DayEightTest < MiniTest::Test

  def test_init
    d = DayEight.new(3, 3)
    assert_equal [['.', '.', '.'], ['.', '.', '.'], ['.', '.', '.']], d.display
  end

  def test_apply
    d = DayEight.new(3, 7)
    d.apply_instructions('input/day_eight_sample.txt')
    d.display_out
    assert_equal 6, d.count_lights
  end

  def test_fill
    d = DayEight.new(3, 7)
    assert_equal [['#', '#', '#', '.', '.', '.', '.'],
                  ['#', '#', '#', '.', '.', '.', '.'],
                  ['.', '.', '.', '.', '.', '.', '.']], d.fill(3, 2)
  end

  def test_rotate_x
    d = DayEight.new(3, 7)
    d.fill(3, 2)
    assert_equal [['#', '.', '#', '.', '.', '.', '.'],
                  ['#', '#', '#', '.', '.', '.', '.'],
                  ['.', '#', '.', '.', '.', '.', '.']], d.rotate_x(1, 1)
  end

  def test_rotate_y
    d = DayEight.new(3, 7)
    d.fill(3, 2)
    assert_equal [['.', '.', '.', '.', '#', '#', '#'],
                  ['#', '#', '#', '.', '.', '.', '.'],
                  ['.', '.', '.', '.', '.', '.', '.']], d.rotate_y(0, 4)
  end

  def test_count_lights
    day = DayEight.new
    day.apply_instructions
    day.display_out
    assert_equal 110, day.count_lights
  end
end