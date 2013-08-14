
class Versions
  attr_accessor :original, :revised

  def initialize(original, revised)
    @original = original
    @revised = revised
  end

  #   Pre: original, revised are arrays.
  #   Returns an array representing the longest common subsequence (lcs) of 
  #   revised and original.
  #   Each element of the returned array is an array of two integers: 
  #     [index of lcs element in original, index of lcs element in revised].
  # 
  def lcs(i=0, j=0, memo={})
    return memo[[original, revised, i, j]] if memo.has_key?([original, revised, i, j])
    return [] if original.empty? || revised.empty?
    if original.first == revised.first
      [[i, j]] + 
        Versions.new(original.drop(1), revised.drop(1)).lcs(i+1, j+1, memo)
    else
      seq1 = memo[[original.drop(1), revised, i+1, j]] = 
        Versions.new(original.drop(1), revised).lcs(i+1, j, memo)
      seq2 = memo[[original, revised.drop(1), i, j+1]] =
        Versions.new(original, revised.drop(1)).lcs(i, j+1, memo)
      if seq1.count >= seq2.count
        seq1
      else
        seq2
      end
    end
  end

  #   Pre: original, revised are arrays;
  #     match is an array containing two element arrays [i, j] such that
  #     original[i] is the same as revised[j].
  #   Returns an array that contains and preserves the order of
  #   all and only the elements of original and of revised.
  #   Elements in original whose index isn't in the first position of an array in
  #   match are displayed as deleted; elements in revised whose index isn't in 
  #   the second position of array in match are displayed as added.
  #
  def diff(match)
    if match.empty?
      original.map { |x| Display.deleted(x) } + revised.map { |x| Display.added(x) }
    elsif match.first[0] == 0 && match.first[1] == 0
      remaining_match = match.drop(1).map { |t| [t[0]-1, t[1]-1] }
      [original[0]] + Versions.new(original.drop(1), revised.drop(1)).diff(remaining_match)
    elsif match.first[0] == 0
      remaining_match = match.map { |t| [t[0], t[1]-1] }
      [Display.added(revised[0])] + Versions.new(original, revised.drop(1)).diff(remaining_match)
    else match.first[1] == 0
      remaining_match = match.map { |t| [t[0]-1, t[1]]}
      [Display.deleted(original[0])] + Versions.new(original.drop(1), revised).diff(remaining_match)
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
    @original = gets.chomp 
    puts 'Enter your revised text:'
    print '> '
    @revised = gets.chomp
  end

  def process_for_char_comparison
    @original = @original.split('')
    @revised = @revised.split('')
  end

  def process_for_word_comparison
    @original = @original.split
    @revised = @revised.split
  end

  def compare_inputs
    v = Versions.new(@original, @revised)
    v.diff(v.lcs)
  end

  def output_char_diff
    puts compare_inputs.join
  end

  def output_word_diff
    puts compare_inputs.join(' ')
  end

end