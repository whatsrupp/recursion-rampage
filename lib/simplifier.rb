class Simplify

  def expression(string)
    fractions(string)
    parentheses(string)
    multiplications(string)
  end

  def multiplications(string)
    non_bracket_mult_regex = /(?:[0-9$]+[a-zA-Z$](?:[\w]*))|(?:[a-zA-Z$]+[0-9$]+(?:[\w]*))/
    string.gsub!(non_bracket_mult_regex, '(\0)')
    parentheses(string)
  end

  def fractions (string)
    simplified_bracket_string = fraction_brackets(string)
    simplified_bracket_string.gsub!('\frac{$}{$}', '$')
    more_fractions = !!(/\\frac{/ =~ simplified_bracket_string)
    return fractions(simplified_bracket_string) if more_fractions
    simplified_bracket_string
  end

  def fraction_brackets(string)
    first_bracket_string = extract_string_between_curly_bracket(string)
    first_bracket_string = '\frac'+first_bracket_string
    test = string.sub(first_bracket_string, '\frac$')
    string.sub!(first_bracket_string, '\frac$')
    second_bracket_string = extract_string_between_curly_bracket(string)
    string.sub!(second_bracket_string, '$')
    string.gsub!('\\frac$$', '\\frac{$}{$}')
  end

  def parentheses(string)
    simplified_string = parentheses_content(string)
    string.gsub!('($)','$')
    more_parentheses = !!(/\(/ =~ string)
    return parentheses(simplified_string) if more_parentheses
    simplified_string
  end

  def parentheses_content(string)
    inner_string = extract_string_from_outer_bracket(string)
    string.sub!(inner_string, '($)')
  end

  def extract_string_from_outer_bracket(string)
    bracket_count = 0
    bracket_start_index = nil

    string.each_char.with_index do |char,index|
      if (char=='(')
        if bracket_count == 0
          bracket_start_index = index
        end
        bracket_count += 1
      end
      if (char==')')
        bracket_count-=1
        if bracket_count == 0
          bracket_end_index = index
          length = bracket_end_index - bracket_start_index
          bracket_string = string[bracket_start_index,bracket_end_index-bracket_start_index+1]
          return bracket_string
        end
      end
    end
    return string

  end


  def extract_string_between_curly_bracket(string)
    bracket_count = 0
    bracket_start_index = nil

    string.each_char.with_index do |char,index|
      if (char=='{')
        if bracket_count == 0
          bracket_start_index = index
        end
        bracket_count += 1
      end
      if (char=='}')
        bracket_count-=1
        if bracket_count == 0
          bracket_end_index = index
          length = bracket_end_index - bracket_start_index
          bracket_string = string[bracket_start_index,bracket_end_index-bracket_start_index+1]
          return bracket_string
        end
      end
    end
    return string
  end

end
