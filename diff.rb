class Versions
  attr_accessor :v1, :v2

  # v1 and v2 are two versions to be compared.
  # They can be strings or arrays.

  def initialize(v1, v2)
    @v1 = v1
    @v2 = v2
  end
  
  # Returns a hash with each key [x,y] having the following value:
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

  def lcs
    @lcs ||= table
  end

  # use table to construct diff.
  # Return an array showing the implied edits in going from v1 to v2.
  #
  def diff(x=v1.length - 1, y=v2.length - 1)
    return [] if x < 0 && y < 0
    return diff(x-1, y) << Display.deleted(v1[x]) if y < 0
    return diff(x, y-1) << Display.added(v2[y]) if x < 0
    if v1[x] == v2[y]
      diff(x-1, y-1) << v1[x]
    elsif lcs[[x-1, y]] >= lcs[[x, y-1]]
      diff(x-1, y) << Display.deleted(v1[x])
    else
      diff(x, y-1) << Display.added(v2[y])  
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
    v.diff
  end

  def output_char_diff
    puts compare_inputs.join
  end

  def output_word_diff
    puts compare_inputs.join(' ')
  end

end

text1 = "This is a smaple longer text so as to see how long it takes. Is the iterative or the memoized version faster?
Here's a continuation of the sample longer text. It seems kind of slow."
text2 = "This is a sample text to see how long it takes. It seems kind of slow. I wonder why. Blah blah.
Here's a continuation of the sample longer text. It does indeed seem quite slow."
#text1 = 'hello this is my first text.'
#text2 = 'hello this is my revised text. It is slightly longer.'
v1 = text1.split
v2 = text2.split
v = Versions.new(v1, v2)
puts v.diff.join(' ')
# output = v.diff
# puts output.join(' ')
