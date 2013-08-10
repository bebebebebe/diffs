require_relative 'colour'
require_relative 'lcs'

# lcs(a,b) ==> [['x',1,2], ['y',3,3]]







def diff(original, modified) #array --> string
  array = []
  hash = match(original, modified)
  (0...length_diff(original, modified)).each do |i|
    if hash.has_key?(i)
      array << original[i]
    else
      array << red(original[i])
    
    end
  end
  array.join
end

#match: lcs (ordered by index in original)
def diffs(a,b, match)
  if match.empty?
    a.map { |x| red(x) } + b.map { |x| green(x) }
  elsif match.first[1] == 0 && match.first[2] == 0
    remaining_match = match.drop(1).map do |triple|
      [triple[0], triple[1] - 1, triple[2] - 1]
    end
    puts remaining_match.inspect
    [a[0]] + diffs(a.drop(1), b.drop(1), remaining_match)
  elsif match.first[1] == 0
    [red(b[0])] + diffs(a, b.drop(1), match.map{ |t| [t[0], t[1], t[2] - 1] })
  else match.first[2] == 0
    [a[0]] + diffs(a.drop(1), b, match.map{ |t| [t[0], t[1] - 1, t[2]] })
  end
end




def match(a,b)
  lcs(a,b).sort { |x,y| x[1] <=> y[1] }
end




def next_key(i, hash)
  key = i + 1
  until hash.has_key?(key)
    key += 1
  end
  key
end

def length_diff(original, modified)
  original.length + modified.length - lcs(original, modified).length
end


def match(original, modified)
  lcs = lcs(original, modified)
  hash = {}
  lcs.each do |triple|
    hash[triple[1]] = triple[2]
  end
  hash
end

# sort triple by second elemnent
def sort_by_middle(triples)
  triples.sort { |x,y| x[1] <=> y[1] }
end



a = %w(c a t)
b = %w(c t p)
puts diffs(a, b, lcs(a,b)).join









