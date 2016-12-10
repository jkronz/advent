require 'minitest/autorun'
require './lib/day_seven'
class DaySevenTest < MiniTest::Test

  def setup
    @day = DaySeven.new
  end

  def test_tls
    assert_equal true, @day.tls?(@day.format_ip('abba[mnop]qrst'))
    assert_equal false, @day.tls?(@day.format_ip('abcd[bddb]xyyx'))
    assert_equal false, @day.tls?(@day.format_ip('aaaa[qwer]tyui'))
    assert_equal true, @day.tls?(@day.format_ip('ioxxoj[asdfgh]zxcvbn'))
  end

  def test_part_one
    assert_equal 105, @day.count_tls
  end

  def test_ssl
    assert_equal true, @day.ssl?(@day.format_ip('aba[bab]xyz'))
    assert_equal false, @day.ssl?(@day.format_ip('xyx[xyx]xyx'))
    assert_equal false, @day.ssl?(@day.format_ip('aaa[aaa]xyx'))
    assert_equal true, @day.ssl?(@day.format_ip('aaa[kek]eke'))
    assert_equal true, @day.ssl?(@day.format_ip('zazbz[bzb]cdb'))
    assert_equal false, @day.ssl?(@day.format_ip('zbz[abz][b]'))
    assert_equal true, @day.ssl?(@day.format_ip('cdc[bzb][b]zbz'))
    assert_equal true, @day.ssl?(@day.format_ip('zbz[zbz][bzb]'))
    assert_equal false, @day.ssl?(@day.format_ip('zbz[abc]bzb'))
    assert_equal false, @day.ssl?(@day.format_ip('qildxsfzfukzbmre[jykfpbbfelicvkqov]pyemzfzobutliokrrox[uplajddwknupdnfje]vombwrjguiukbiwozj[kcutkvgruxqqcuykn]zsbonxyerpjkfpnxchj'))
    assert_equal false, @day.ssl?(@day.format_ip('zwosebsoogknldkh[mkcucbphbvnaqyxjope]aibznttouadentsy[xfucuvnlnchuawcapcq]jqherkgzqodpzydtgu'))
  end

  def test_part_two
    assert_equal 258, @day.count_ssl
  end
end