require 'minitest/autorun'
require './lib/day_four'
class DayFourTest < MiniTest::Test
  def setup
    @day = DayFour.new
  end

  def test_parse
    room = @day.parse('aaaaa-bbb-z-y-x-123[abxyz]')
    assert_equal 'aaaaa-bbb-z-y-x', room[:name]
    assert_equal 123, room[:sector]
    assert_equal 'abxyz', room[:checksum]
  end

  def test_expected_checksum
    @day = DayFour.new
    assert_equal 'baxyz', @day.expected_checksum('aaaaa-bbbbbbb-z-y-x')
  end

  def test_process
    assert_equal 185371, @day.process_input
  end

  def test_decrypted_name
    room = @day.parse('qzmt-zixmtkozy-ivhz-343[check]')
    assert_equal 'very encrypted name', @day.decrypted_name(room)
  end
end