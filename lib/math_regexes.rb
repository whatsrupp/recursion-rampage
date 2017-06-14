module MathRegexes

  def minus_regex
     /-/
  end

  add_regex = /[^\+]+/
  check_for_minuses=/-/
  digit_regex = /[\-|\d]/
  minus_regex = /(?:\-.*?(?=-))|(?:\-.*)/
  mult_regex = /-?(?:\d+|\w|\$)/
  mult_filter_regex = /(\([^\)]+\)+)/
  non_bracket_mult_regex = /(?:[0-9]+[a-zA-Z](?:[\w]*))|(?:[a-zA-Z]+[0-9]+(?:[\w]*))/
  div_regex = /\\frac{.*}/
  between_curly_regex =/[^{]+(?=})/
  between_parentheses_regex = /\(([^\)]+)\)/
  between_frac_regex = /\{([^\}]+)\}/
  initial_regex = /(\{[^\}]+\})|(\([^\)]+\))/

end
