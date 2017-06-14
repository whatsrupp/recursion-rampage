class Simplify

  def simplify(string)
    fraction_brackets(string)
  end

  def fraction (string)
    simplified_bracket_string = fraction_brackets(string)
    simplified_bracket_string.gsub!('\frac{$}{$}', '$')
  end

  def fraction_brackets(string)
    first_bracket_string = extract_string_between_curly_bracket(string)
    first_bracket_string = '\frac'+first_bracket_string
    string.gsub!(first_bracket_string, '\frac$')
    second_bracket_string = extract_string_between_curly_bracket(string)
    string.gsub!(second_bracket_string, '$')
    string.gsub!('{$}', '$')
    string.gsub!('$','{$}')
  end

  def parentheses(string)
    simplified_string = parentheses_content(string)
    string.gsub!('($)','$')
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
