require 'minitest/autorun'


def subseq?(s,t) # string s is a subsequence of t
  t_array = t.split('')
  s_array = s.split('')
  subarray?(t_array, s_array)
end


def var_subarray?(a,b)
  until a.empty?
    last = a.pop
    while last != b.pop
      return false if b.empty?
    end
  end
  true
end

# recursive
def subarray?(a,b)
  return true if a.empty?
  to_match = a.pop
  while to_match != b.pop
    return false if b.empty?
  end
  subarray?(a,b)
end



def subarr?(a,b)
  a.each do |x|
    return false if b.length == 0
    while b.first != x
      b = b.drop(1)
      return false if b.empty?
    end
    b = b.drop(1)
  end
  true
end


def subseq(a,b,memo={})
  return memo[[a,b]] if memo.has_key?([a,b])
  return [] if a.empty? || b.empty?
  if a.first == b.first
    [a.first] + subseq(a.drop(1), b.drop(1), memo)
  else
    seq1 = memo[[a.drop(1),b]] = subseq(a.drop(1), b, memo)
    seq2 = memo[[a,b.drop(1)]] = subseq(a, b.drop(1), memo)
    if seq1.count >= seq2.count
      seq1
    else
      seq2
    end
  end
end

# memoize
def subseq_index(a,b,i=0,j=0, memo={})
  return memo[[a,b,i,j]] if memo.has_key?([a,b,i,j])
  return [] if a.empty? || b.empty?
  if a.first == b.first
    [[a.first,i,j]] + subseq_index(a.drop(1), b.drop(1), i+1, j+1, memo)
  else
    seq1 = memo[[a.drop(1), b, i+1, j]] = subseq_index(a.drop(1), b, i+1, j, memo)
    seq2 = memo[[a, b.drop(1), i, j+1]] = subseq_index(a, b.drop(1), i, j+1, memo)
    if seq1.count >= seq2.count
      seq1
    else
      seq2
    end
  end
end


# def subseq_index(a,b,p_a=0,p_b=0)
#   return [] if a.empty? || b.empty?
#   if a.first == b.first
#     [[a.first,p_a,p_b]] + subseq_index(a.drop(1), b.drop(1), p_a+1, p_b+1)
#   else
#     seq1 = subseq_index(a.drop(1), b, p_a+1, p_b)
#     seq2 = subseq_index(a, b.drop(1), p_a, p_b+1)
#     if seq1.count >= seq2.count
#       seq1
#     else
#       seq2
#     end
#   end
# end




class TestIndexSeq < MiniTest::Unit::TestCase
  def test_a_empty
    assert_equal(subseq_index([], [1,2]), [])
  end

  def test_b_empty
    assert_equal(subseq_index([1,2,3], []), [])
  end

  def test_a_subseq_b
    assert_equal(subseq_index([1,2], [5,1,3,2,5]), ([[1,0,1], [2,1,3]]))
  end

  def test_a_overlap_b
    assert_equal(subseq_index([1,2,5], [5,1,3,2,5]), ([[1,0,1], [2,1,3] ,[5,2,4]]))
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
    assert_equal(subseq([1,2,5], [5,1,3,2,5]), [1,2,5])
  end


end











# ****************

def uptolast!(array, char)
  while array.length != 0
    return array if array.pop == char
  end
end

def contains?(string, x)
  string.each_char do |char|
    return true if char == x
  end
  false
end

# ******************

class TestSubseq < MiniTest::Unit::TestCase

  def test_same_array
    a = [1,2,3]
    b = [1,2,3]
    assert_equal(subarray?(a,b), true)
  end

  def test_a_empty
    a = []
    b = [1]
    assert_equal(subarray?(a,b), true)
  end

  def test_b_empty
    a = [1]
    b = []
    assert_equal(subarray?(a,b), false)
  end

  def test_basic_true
    a = [1,2]
    b = [5,6,1,7,2]
    assert_equal(subarray?(a,b), true)
  end

  def test_basic_false
    a = [1,2]
    b = [5,6,1,7]
    assert_equal(subarray?(a,b), false)
  end

 end




