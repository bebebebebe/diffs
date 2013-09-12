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
  # Returns array with elements [x,y] with v1[x] == v2[y] making up the lcs.
  #
  def longest_common_subseq(x=v1.length - 1, y=v2.length - 1)
    return [] if table[[x,y]] == 0
    if v1[x] == v2[y]
      longest_common_subseq(x-1, y-1) << [x,y]
    elsif table[[x-1, y]] >= table[[x, y-1]]
      longest_common_subseq(x-1, y)
    else
      longest_common_subseq(x, y-1)
    end
  end

  # Returns a hash with each key [x,y] having the value:
  # length of the longest common subsequence of
  # the prefix of v1 up to index x, and the prefix of v2 up to the index y.
  #
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
 
  #   Given a common subsequence, return an array showing the implied edits
  #   in going from v1 to v2.
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

class CommandLineDiff
  
  def char_based
    get_inputs
    process_for_char_comparison
    compare_inputs
    output_char_diff
  end

  def word_based
    get_inputs
    process_for_word_comparison
    compare_inputs
    output_word_diff
  end

  def get_inputs
    puts 'Enter your first text:'
    print '> '
    @v1 = gets.chomp 
    puts 'Enter your revised text:'
    print '> '
    @v2 = gets.chomp
  end

  def process_for_char_comparison
    @v1 = @v1.split('')
    @v2 = @v2.split('')
  end

  def process_for_word_comparison
    @v1 = @v1.split
    @v2 = @v2.split
  end

  def compare_inputs
    v = Versions.new(@v1, @v2)
    v.diff(v.longest_common_subseq)
  end

  def output_char_diff
    puts compare_inputs.join
  end

  def output_word_diff
    puts compare_inputs.join(' ')
  end

end