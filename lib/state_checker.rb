module StateChecker


  def needs_add_simplification(string)
    plus_regex = /\+/
    minus_regex = /-/
    string[0] = '' if (/-/ =~ string) == 0
    plusses= !string.scan(plus_regex).empty?
    minuses= !string.scan(minus_regex).empty?
    plusses || minuses
  end

  def needs_mult_simplification(string)
    mult_regex = /[a-zA-Z][\d]|[\d][a-zA-Z]|-[a-zA-Z]/
    !!(mult_regex =~ string)
  end
end
