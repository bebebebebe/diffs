def lcs_length(a,b)
  return 0 if a.empty? || b.empty?
  if a.first == b.first
    1 + lcs_length(a.drop(1), b.drop(1))
  else
    len1 = lcs_length(a.drop(1), b)
    len2 = lcs_length(a, b.drop(1))
    if len1 >= len2
      len1
    else
      len2
    end
  end
end

# memoized
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

# with indices, memoization
def lcs(a,b,i=0,j=0, memo={})
  return memo[[a,b,i,j]] if memo.has_key?([a,b,i,j])
  return [] if a.empty? || b.empty?
  if a.first == b.first
    [[a.first,i,j]] + lcs(a.drop(1), b.drop(1), i+1, j+1, memo)
  else
    seq1 = memo[[a.drop(1), b, i+1, j]] = lcs(a.drop(1), b, i+1, j, memo)
    seq2 = memo[[a, b.drop(1), i, j+1]] = lcs(a, b.drop(1), i, j+1, memo)
    if seq1.count >= seq2.count
      seq1
    else
      seq2
    end
  end
end

# with indeces, not memoized
def subseq_index(a,b,p_a=0,p_b=0)
  return [] if a.empty? || b.empty?
  if a.first == b.first
    [[a.first,p_a,p_b]] + subseq_index(a.drop(1), b.drop(1), p_a+1, p_b+1)
  else
    seq1 = subseq_index(a.drop(1), b, p_a+1, p_b)
    seq2 = subseq_index(a, b.drop(1), p_a, p_b+1)
    if seq1.count >= seq2.count
      seq1
    else
      seq2
    end
  end
end

def diffs(a,b, match)
    if match.empty?
      a.map { |x| red(x) } + b.map { |x| green(x) }
    elsif match.first[1] == 0 && match.first[2] == 0
      remaining_match = match.drop(1).map do |t|
        [t[0], t[1]-1, t[2]-1]
      end
      [a[0]] + diffs(a.drop(1), b.drop(1), remaining_match)
    elsif match.first[1] == 0
      [green(b[0])] + diffs(a, b.drop(1), match.map{ |t| [t[0], t[1], t[2] - 1] })
    else match.first[2] == 0
      [red(a[0])] + diffs(a.drop(1), b, match.map{ |t| [t[0], t[1] - 1, t[2]] })
    end
  end



def length_diff(original, modified)
  original.length + modified.length - lcs(original, modified).length
end



# a = 'Hello, how are you?'.split('')
# b = 'Hi, how are you??'.split('')
# puts 'original: ' + a.join
# puts 'revision: ' + b.join
# puts 'diff: ' + diffs(a, b, lcs(a,b)).join



