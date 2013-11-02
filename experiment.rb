#   def longest_common_subseq(i=0, j=0, memo={})
#     return memo[[original, revised, i, j]] if memo.has_key?([i, j])
#     return [] if original.empty? || revised.empty?  
#     if original.first == revised.first
#       [[i, j]] + 
#         Versions.new(original.drop(1), revised.drop(1)).longest_common_subseq(i+1, j+1, memo)
#     else
#       seq1 = memo[[original.drop(1), revised, i+1, j]] = 
#         Versions.new(original.drop(1), revised).longest_common_subseq(i+1, j, memo)
#       seq2 = memo[[original, revised.drop(1), i, j+1]] =
#         Versions.new(original, revised.drop(1)).longest_common_subseq(i, j+1, memo)
#       if seq1.count >= seq2.count
#         seq1
#       else
#         seq2
#       end
#     end
#   end


# def longest_common_subseq(i=0, j=0, memo={})                    
#   return memo[[i, j]] if memo.has_key?([i, j])                        
#   return [] if i >= original.length || j >= revised.length            
#   if original[i] == revised[j]                                        
#     [[i, j]] + longest_common_subseq(i+1, j+1, memo)            
#   else                                                                
#     seq1 = memo[[i+1, j]] = longest_common_subseq(i+1, j, memo) 
#     seq2 = memo[[i, j+1]] = longest_common_subseq(i, j+1, memo) 
#     [seq1, seq2].max_by { |x| x.count }                                                            
#   end                                                                 
# end

 def longest_common_subseq(i, j)                                
   return [] if i >= original.length || j >= revised.length            
   if original[i] == revised[j]                                        
     [[i, j]] + longest_common_subseq(i+1, j+1)            
   else                                                                
     seq1 = longest_common_subseq(i+1, j, memo) 
     seq2 = longest_common_subseq(i, j+1, memo) 
     [seq1, seq2].max_by { |x| x.count }                                                            
   end                                                                 
 end

# no memoization:
def lcs(i=0,j=0)
  return [] if i >= original.length || j >= revised.length
  if original[i] == revised[j]
    [[i,j]] + lcs(i+1, j+1)
  else
    seq1 = lcs(i+1, j)
    seq2 = lcs(i, j+1)
    [seq1, seq2].max_by { |x| x.count }
  end
end
















