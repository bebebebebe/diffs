# use ruby-prof to compare times of these two methods

class Versions
  attr_accessor :original, :revised

  def initialize(original, revised)
    @original = original
    @revised = revised
  end

  def lcs_no_memo(i=0, j=0)
    return [] if original.empty? || revised.empty?
    if original.first == revised.first
      [[original.first, i, j]] + 
          Versions.new(original.drop(1), revised.drop(1)).lcs_no_memo(i+1, j+1)
    else
      seq1 = Versions.new(original.drop(1), revised).lcs_no_memo(i+1, j)
      seq2 = Versions.new(original, revised.drop(1)).lcs_no_memo(i, j+1)
      if seq1.count >= seq2.count
        seq1
      else
        seq2
      end
    end
  end

  def lcs(i=0, j=0, memo={})
    return memo[[original, revised, i, j]]
    return [] if original.empty? || revised.empty?
    if original.first == revised.first
      [[original.first, i, j]] + 
          Versions.new(original.drop(1), revised.drop(1)).lcs(i+1, j+1, memo)
    else
      seq1 = memo[original.drop(1), revised, i+1, j] = 
        Versions.new(original.drop(1), revised).lcs(i+1, j, memo)
      seq2 = memo[original, revised.drop(1), i, j+1]
        Versions.new(original, revised.drop(1)).lcs(i, j+1, memo)
      if seq1.count >= seq2.count
        seq1
      else
        seq2
      end
    end
  end

end