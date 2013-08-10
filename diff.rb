
class Versions
  attr_accessor :original, :revised

  def initialize(original, revised)
    @original = original
    @revised = revised
  end

  def lcs(i=0, j=0, memo={})
    return memo[[original, revised, i, j]] if memo.has_key?([original, revised, i, j])
    return [] if original.empty? || revised.empty?
    if original.first == revised.first
      [[original.first, i, j]] + 
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

  def diff(match)
    if match.empty?
      original.map { |x| Display.deleted(x) } + revised.map { |x| Display.added(x) }
    elsif match.first[1] == 0 && match.first[2] == 0
      remaining_match = match.drop(1).map { |t| [t[0], t[1]-1, t[2]-1] }
      [original[0]] + Versions.new(original.drop(1), revised.drop(1)).diff(remaining_match)
    elsif match.first[1] == 0
      remaining_match = match.map { |t| [t[0], t[1], t[2]-1] }
      [Display.added(revised[0])] + Versions.new(original, revised.drop(1)).diff(remaining_match)
    else match.first[2] == 0
      remaining_match = match.map { |t| [t[0], t[1]-1, t[2]]}
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

class GiveDiff
  attr_accessor :original, :revised

  def compare
    get_original
    get_revised
    process
    output_diff
  end

  def get_original
    puts 'Enter your first text:'
    print '> '
    first = gets.chomp
    @original = first.split('')
  end

  def get_revised
    puts 'Enter your revised text:'
    print '> '
    second = gets.chomp
    @revised = second.split('')
  end

  def process
    v = Versions.new(@original, @revised)
    v.diff(v.lcs)
  end

  def output_diff
    puts process.join
  end

end



# orig = 'hi, how are you today?'.split('')
# rev = 'hello, how are you?'.split('')


# v = Versions.new(orig, rev)

# puts v.diff(v.lcs).join










