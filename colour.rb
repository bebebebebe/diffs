def colour(text, code)
  "\e[#{code}m#{text}\e[0m"
end

def red(text)
  colour(text, 31)
end

def green(text)
  colour(text, 32)
end