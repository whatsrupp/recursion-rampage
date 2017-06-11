module StateChecker


  def needs_add_simplification(string)
    string = string.dup
    plus_regex = /\+/
    minus_regex = /-/
    unary_regex =/[\+-]@/
    string[0] = '' if (/-/ =~ string) == 0
    plusses= !string.scan(plus_regex).empty?
    minuses= !string.scan(minus_regex).empty?
    not_unary = string.scan(unary_regex).empty?
    (plusses && not_unary) || minuses
  end

  def needs_mult_simplification(string)
    mult_regex = /[a-zA-Z][\d]|[\d][a-zA-Z]|-[a-zA-Z]/
    trailing_brackets_regex = /[a-zA-Z0-9]\(/
    leading_brackets_regex = /\)[a-zA-Z0-9]/

    digits_and_characters = !!(mult_regex =~ string)
    trailing_brackets = !!(trailing_brackets_regex =~ string)
    leading_brackets = !!(leading_brackets_regex =~ string)
    digits_and_characters || trailing_brackets || leading_brackets
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
