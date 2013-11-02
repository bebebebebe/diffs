require 'minitest/autorun'
require_relative '../lcs.rb'


class TestIndexSeq < MiniTest::Unit::TestCase
  def test_a_empty
    assert_equal(lcs([], [1,2]), [])
  end

  def test_b_empty
    assert_equal(lcs([1,2,3], []), [])
  end

  def test_a_subseq_b
    assert_equal(lcs([1,2], [5,1,3,2,5]), ([[1,0,1], [2,1,3]]))
  end

  def test_a_overlap_b
    assert_equal(lcs([1,2,5], [5,1,3,2,5]), ([[1,0,1], [2,1,3] ,[5,2,4]]))
  end

end



class TestSeq < MiniTest::Unit::TestCase

  def test_a_empty
    assert_equal(subseq([], [1,2]), [])
  end

  def test_b_empty
    assert_equal(subseq([1,2,3], []), [])
  end

  def test_a_subseq_b
    assert_equal(subseq([1,2], [5,1,3,2,5]), [1,2])
  end

  def test_a_overlap_b
    assert_equal(subseq([1,2,5], [5,1,3,5]), [1,5])
  end

end


class TestLCS < MiniTest::Unit::TestCase

  def test_lcs_length_empty
    a = []
    b = [1]
    assert_equal(lcs_length(a,b), 0)
  end

  def test_lcs_length_identical
    a = [1,2,3]
    b = [1,2,3]
    assert_equal(lcs_length(a,b), 3)
  end

  def test_lcs_length_one_common
    a = [1,2,3,4]
    b = [9,2,5]
    assert_equal(lcs_length(a,b), 1)
  end

end