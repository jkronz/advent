require 'minitest/autorun'
require './lib/day_six'
class DaySixTest < MiniTest::Test
  def setup
    @example = DaySix.new('input/day_six_example.txt')
    @final = DaySix.new('input/day_six.txt')
  end

  def test_part_one
    assert_equal 'easter', @example.count
    assert_equal 'asvcbhvg', @final.count
  end

  def test_part_two
    assert_equal 'advent', @example.count(false)
    assert_equal 'odqnikqv', @final.count(false)
  end
end
