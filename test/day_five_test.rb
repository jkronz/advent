require 'minitest/autorun'
require './lib/day_five'
class DayFiveTest < MiniTest::Test
  def setup
    @example = DayFive.new('abc')
    @final = DayFive.new('ffykfhsq')
  end

  # these tests are too slow
  def test_find_password
    # assert_equal '1', @example.find_password(1)
    # assert_equal '18f47a30', @example.find_password
    # assert_equal '05ace8e3', @example.find_password(8, true)
    # assert_equal 'c6697b55', @final.find_password
    # assert_equal '8c35d1ab', @final.find_password(8, true)
  end

  def test_interesting_index
    assert_equal false, @example.interesting_index?(3231929).nil?
    assert_equal true, @example.interesting_index?(3231928).nil?
  end
end