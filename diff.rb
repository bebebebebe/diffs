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

def diffs(a,b)
  keys = match(a,b).keys
  if keys.empty?
    array = a.map { |x| red(x) } + b.map { |x| green(x) }
    return array.join
  else
    

    
  end
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


puts diffs(%w(a n d), %w(t h e))