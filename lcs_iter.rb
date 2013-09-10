class Versions
  attr_accessor :string_x, :string_y

  def initialize(string_x, string_y)
    @string_x = string_x
    @string_y = string_y
  end

  # use table to construct the longest common subsequence of
  # prefixes of string_x up to index x and string_y up to index y, respectively
  def longest_common_subsequence(x=string_x.length - 1, y=string_y.length - 1)
    return '' if table[[x,y]] == 0
    if string_x[x] == string_y[y]
      make_lcs(string_x[0...x], string_y[0...y], table, x-1, y-1) + string_x[x]
    elsif table[[x-1, y]] >= table[[x, y-1]]
      make_lcs(string_x[0...x], string_y[0..y], table, x-1, y)
    else
      make_lcs(string_x[0..x], string_y[0...y], table, x, y-1)
    end
  end

  # return table: lcs[i,j] is the length of the longest common subsequence of
  # the length x prefix of string_x and the length y prefix of string_y.
  def table
    table = {}
    (-1...string_x.length).each { |x| table[[x, -1]] = 0 }
    (0...string_y.length).each { |y| table[[-1, y]] = 0 }

    (0...string_x.length).each do |x|
      (0...string_y.length).each do |y|
        if string_x[x] == string_y[y]
          table[[x,y]] = table[[x-1, y-1]] + 1
        else
          table[[x,y]] = [table[[x-1,y]], table[[x,y-1]]].max
        end
      end
    end

    table
  end

end


