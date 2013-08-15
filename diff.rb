
class Versions
  attr_accessor :original, :revised
  #   original, revised are arrays.

  def initialize(original, revised)
    @original = original
    @revised = revised
  end

  
  #   A common subsequence is an array of pairs [i, j] such that 
  #   original[i] == revised[j], with later pairs having greater
  #   indices (i.e., they are in increasing order).
  #
  #   Given indices i of original and j of revised, return a longest common
  #   subsequence of original from index i and revised from index j.
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

 
  #   Given a common subsequence, return an array showing the implied edits
  #   in going from original to revised.
  #
  def diff(matches)
    if matches.empty?
      original.map { |x| Display.deleted(x) } + revised.map { |x| Display.added(x) }
    elsif matches.first[0] == 0 && matches.first[1] == 0
      remaining_matches = matches.drop(1).map { |t| [t[0]-1, t[1]-1] }
      [original[0]] + Versions.new(original.drop(1), revised.drop(1)).diff(remaining_matches)
    elsif matches.first[0] == 0
      remaining_matches = matches.map { |t| [t[0], t[1]-1] }
      [Display.added(revised[0])] + Versions.new(original, revised.drop(1)).diff(remaining_matches)
    else matches.first[1] == 0
      remaining_matches = matches.map { |t| [t[0]-1, t[1]]}
      [Display.deleted(original[0])] + Versions.new(original.drop(1), revised).diff(remaining_matches)
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