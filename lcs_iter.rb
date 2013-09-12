class Versions
  attr_accessor :v1, :v2

  # v1 and v2 are two versions to be compared.
  # They can be strings or arrays.

  def initialize(v1, v2)
    @v1 = v1
    @v2 = v2
  end

  # Uses table below to construct the longest common subsequence of
  # prefixes of v1 up to index x and v2 up to index y, respectively.
  # Returns array with elements [x,y] with v1[x] == v2[y] making up the lcs
  def longest_common_subsequence(x=v1.length - 1, y=v2.length - 1)
    return [] if table[[x,y]] == 0
    if v1[x] == v2[y]
      longest_common_subsequence(x-1, y-1) << [x,y]
    elsif table[[x-1, y]] >= table[[x, y-1]]
      longest_common_subsequence(x-1, y)
    else
      longest_common_subsequence(x, y-1)
    end
  end

  # Returns a hash with each key [x,y] having the value:
  # length of the longest common subsequence of
  # the prefix of v1 up to index x, and the prefix of v2 up to the index y.
  def table
    table = {}
    (-1...v1.length).each { |x| table[[x, -1]] = 0 }
    (0...v2.length).each { |y| table[[-1, y]] = 0 }

    (0...v1.length).each do |x|
      (0...v2.length).each do |y|
        if v1[x] == v2[y]
          table[[x,y]] = table[[x-1, y-1]] + 1
        else
          table[[x,y]] = [table[[x-1,y]], table[[x,y-1]]].max
        end
      end
    end
    table
  end

end