require 'minitest/autorun'
require './lib/day_twelve'
class DayTwelveTest < MiniTest::Test

  def test_part_one
    day = DayTwelve.new
    day.execute
  end
end