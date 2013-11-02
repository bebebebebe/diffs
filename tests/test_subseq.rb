require 'minitest/autorun'
require_relative '../subseq.rb'

class TestSubseq < MiniTest::Unit::TestCase

  def test_same_array
    a = [1,2,3]
    b = [1,2,3]
    assert_equal(subseq?(a,b), true)
  end

  def test_a_empty
    a = []
    b = [1]
    assert_equal(subseq?(a,b), true)
  end

  def test_b_empty
    a = [1]
    b = []
    assert_equal(subseq?(a,b), false)
  end

  def test_basic_true
    a = [1,2]
    b = [5,6,1,7,2]
    assert_equal(subseq?(a,b), true)
  end

  def test_basic_false
    a = [1,2]
    b = [5,6,1,7]
    assert_equal(subseq?(a,b), false)
  end

 end