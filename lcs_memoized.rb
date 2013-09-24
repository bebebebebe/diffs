class Versions
  attr_accessor :v1, :v2

  # v1 and v2 are two versions to be compared.
  # They can be strings or arrays.

  def initialize(v1, v2)
    @v1 = v1
    @v2 = v2
  end


  def longest_common_subseq(i=0, j=0, memo={})
    if memo.has_key?([v1, v2, i, j])
      return memo[[v1, v2, i, j]]
    elsif v1.empty? || v2.empty?
      return []
    elsif v1.first == v2.first
      [[i, j]] + 
        Versions.new(v1.drop(1), v2.drop(1)).longest_common_subseq(i+1, j+1, memo)
    else
      seq1 = memo[[v1.drop(1), v2, i+1, j]] = 
        Versions.new(v1.drop(1), v2).longest_common_subseq(i+1, j, memo)
      seq2 = memo[[v1, v2.drop(1), i, j+1]] =
        Versions.new(v1, v2.drop(1)).longest_common_subseq(i, j+1, memo)
      if seq1.count >= seq2.count
        seq1
      else
        seq2
      end
    end
  end


  # Given a common subsequence, return an array showing the implied edits
  # in going from v1 to v2.
  #
  def diff(matches)
    if matches.empty?
      v1.map { |x| Display.deleted(x) } + v2.map { |x| Display.added(x) }
    elsif matches.first[0] == 0 && matches.first[1] == 0
      remaining_matches = matches.drop(1).map { |t| [t[0]-1, t[1]-1] }
      [v1[0]] + Versions.new(v1.drop(1), v2.drop(1)).diff(remaining_matches)
    elsif matches.first[0] == 0
      remaining_matches = matches.map { |t| [t[0], t[1]-1] }
      [Display.added(v2[0])] + Versions.new(v1, v2.drop(1)).diff(remaining_matches)
    else matches.first[1] == 0
      remaining_matches = matches.map { |t| [t[0]-1, t[1]] }
      [Display.deleted(v1[0])] + Versions.new(v1.drop(1), v2).diff(remaining_matches)
    end
  end

end

module Display
  def self.deleted(x)
    red(x)
  end

  def self.added(x)
    green(x)
  end

  def self.colour(text, code)
    "\e[#{code}m#{text}\e[0m"
  end

  def self.red(text)
    colour(text, 31)
  end

  def self.green(text)
    colour(text, 32)
  end
end