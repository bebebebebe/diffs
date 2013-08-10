Diffs
=====

Command line tool that asks the user for two input ("original" and "revision") strings and outputs their character based difference: characters deleted from the original appear in red, characters added in the revision appear in green, and characters common to both inputs appear in black.

How is the diff determined? For strings s and t, s is a substring of t if every element of s is present in the same order (but not necessarily contiguously) in t.  The common characters (ouput in black) are taken to be those in the longest string that is a subsequence of both the original and of the revision. Characters present in the original that are not in this subsequence are taken to be deletions (red), and characters present in the revision that are not in this subsequence are taken to be additions (green).

And how do you find the longest common subsequence of two strings? By recursion on the length of the strings.