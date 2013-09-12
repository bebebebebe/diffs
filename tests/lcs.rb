require 'minitest/autorun'
require_relative '../diff'

class TestLongestCommonSubseq < MiniTest::Unit::TestCase
  def test_a_empty
    original = []
    revised = [1,2]
    v = Versions.new(original, revised)
    assert_equal(v.longest_common_subseq, [])
  end

  def test_b_empty
    original = [1,2,3]
    revised = []
    v = Versions.new(original, revised)
    assert_equal(v.longest_common_subseq, [])
  end

  def test_a_subseq_b
    original = [1,2]
    revised = [5,1,3,2,5]
    v = Versions.new(original, revised)
    assert_equal(v.longest_common_subseq, ([[0,1], [1,3]]))
  end

  def test_a_overlap_b
    original = [1,2,5]
    revised = [5,1,3,2,5]
    v = Versions.new(original, revised)
    assert_equal(v.longest_common_subseq, ([[0,1], [1,3] ,[2,4]]))
  end

end