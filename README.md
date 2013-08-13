Diffs
=====

Command line tool that asks the user for two input ("original" and "revision") strings and outputs their difference: items deleted from the original appear in red, those added in the revision appear in green, and those common to both inputs appear in black. "Items" here can be taken to be either words (run get_word_diff.rb) or characters (run get_char_diff.rb).


How is the diff determined? For sequences s and t, s is a subequence of t if every element of s is present in the same order (but not necessarily contiguously) in t.  The common items (ouput in black) are taken to be those in the longest sequence that is a subsequence of both the original and of the revision. Items present in the original that are not in this subsequence are taken to be deletions (red), and those present in the revision that are not in this subsequence are taken to be additions (green).

And how do you find the longest common subsequence of two sequences? By recursion on the length of the sequences.