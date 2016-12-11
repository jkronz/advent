require 'minitest/autorun'
require './lib/day_eleven'
class DayElevenTest < MiniTest::Test

  def test_valid
    day = DayEleven.new
    assert_equal true, day.valid?({ elevator: 0, state: [['A', 'a'],
                                                         ['B', 'C', 'D', 'E'],
                                                         ['b', 'c', 'd', 'e'],
                                                         []] })
    assert_equal false, day.valid?({ elevator: 1, state: [['A'],
                                                          ['a', 'B', 'C', 'D', 'E'],
                                                          ['b', 'c', 'd', 'e'],
                                                          []] })
    assert_equal true, day.valid?({ elevator: 1, state: [[],
                                                         ['A', 'a', 'B', 'C', 'D', 'E'],
                                                         ['b', 'c', 'd', 'e'],
                                                         []] })

  end

  def test_next_moves
    day = DayEleven.new
    assert_equal day.next_moves(day.step_tree).count, 3
  end

  def test_build_tree
    # day = DayEleven.new
    # node = day.build_tree
    # steps = 0
    # while node != nil
    #   node = node.parent
    #   steps += 1
    # end
    # assert_equal steps - 1, 57
  end

  def test_equal_move
    state1 = { floor: 0, state: [['A'],
                                 ['a'],
                                 ['B', 'b'],
                                 ['C', 'c']] }
    state2 = { floor: 0, state: [['B'],
                                 ['b'],
                                 ['B', 'b'],
                                 ['C', 'c']] }
    day = DayEleven.new
    assert_equal true, day.equal_move(state1, state2)
  end
end
