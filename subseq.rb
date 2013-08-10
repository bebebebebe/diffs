def subseq?(s,t)
  return true if s.empty?
  return false if t.empty?
  if s.first == t.first
    subseq?(s.drop(1), t.drop(1))
  else
    subseq?(s, t.drop(1))
  end
end


# destructive
def subarray?(a,b)
  until a.empty?
    last = a.pop
    while last != b.pop
      return false if b.empty?
    end
  end
  true
end
