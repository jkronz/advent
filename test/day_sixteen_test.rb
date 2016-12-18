require 'minitest/autorun'
require './lib/day_sixteen'
class DaySixteenTest < MiniTest::Test

  def test_dragon
    day = DaySixteen.new(20, '101')
    assert_equal '100', day.dragon('1')
    assert_equal '001', day.dragon('0')
    assert_equal '11111000000', day.dragon('11111')
    assert_equal '1111000010100101011110000', day.dragon('111100001010')
  end

  def test_example
    day = DaySixteen.new('10000', 20)
    assert_equal '10000011110010000111', day.fill
  end

  def test_checksum
    day = DaySixteen.new('10000', 20)
    assert_equal '0111110101', day.reduce_checksum('10000011110010000111')
    assert_equal '01100', day.checksum('10000011110010000111')
  end

  def test_input
    day = DaySixteen.new('10111100110001111', 272)
    assert_equal '11100110111101110', day.fill_disk
  end

  def test_long_input
    day = DaySixteen.new('10111100110001111', 35651584)
    assert_equal '10001101010000101', day.fill_disk
  end

end
