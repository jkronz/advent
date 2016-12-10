require 'minitest/autorun'
require './lib/day_nine'
class DayNineTest < MiniTest::Test

  def test_plain
    d = DayNine.new
    assert_equal 'ADVENT'.length, d.process_string('ADVENT')
  end

  def test_ex1
    d = DayNine.new
    assert_equal 'ABBBBBC'.length, d.process_string('A(1x5)BC')
  end

  def test_ex2
    d = DayNine.new
    assert_equal 'XYZXYZXYZ'.length, d.process_string('(3x3)XYZ')
  end

  def test_ex3
    d = DayNine.new
    assert_equal 'X(3x3)ABC(3x3)ABCY'.length, d.process_string('X(8x2)(3x3)ABCY')
  end

  def test_input
    d = DayNine.new
    assert_equal 150914, d.process
  end

  def test_1
    d = DayNine.new
    assert_equal 'XABCABCABCABCABCABCY'.length, d.data_length('X(8x2)(3x3)ABCY')
  end

  def test_tail
    d = DayNine.new
    assert_equal 'XABCABCABCABCABCABCY'.length, d.data_len('X(8x2)(3x3)ABCY')
    assert_equal 'CJZOBLWTYDISRYKVWHJKRDDNHSABE'.length, d.data_len('(29x1)CJZOBLWTYDISRYKVWHJKRDDNHSABE')
    # assert_equal 11052855125, d.data_len(File.open('input/day_nine.txt', 'r').read)
  end

  def test_part_two
    # d = DayNine.new
    # assert_equal 11052855125, d.data_length(File.open('input/day_nine.txt', 'r').read)
  end
end
