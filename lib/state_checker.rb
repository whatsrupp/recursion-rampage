module StateChecker


  def needs_add_simplification(string)
    string = string.dup
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

  def needs_div_simplification(string)
    div_regex = /\\frac{.+}{.+}/
    !!(div_regex =~ string)
  end

  def needs_simplification(string)
    return true if needs_div_simplification(string)
    return true if needs_mult_simplification(string)
    return true if needs_add_simplification(string)
    return false
  end
end
