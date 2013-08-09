require 'minitest/autorun'


def subseq?(s,t)
  return true if s.empty?
  return false if t.empty?
  if s.first == t.first
    subseq?(s.drop(1), t.drop(1))
  else
    subseq?(s, t.drop(1))
  end
end


# destructive
def subarray?(a,b)
  until a.empty?
    last = a.pop
    while last != b.pop
      return false if b.empty?
    end
  end
  true
end


# ******************

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




