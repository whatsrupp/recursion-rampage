class Simplify

  attr_reader :replaced_content
  attr_reader :string

  def initialize (string)
    @replaced_content = []
    @string = string
  end

  def expression
    fractions
    parentheses
    multiplications
  end

  def multiplications
    non_bracket_mult_regex = /(?:[0-9$]+[a-zA-Z$](?:[\w]*))|(?:[a-zA-Z$]+[0-9$]+(?:[\w]*))/
    string.gsub!(non_bracket_mult_regex, '(\0)')
    parentheses
  end

  def fractions
    simplified_bracket_string = fraction_brackets
    simplified_bracket_string.gsub!('\frac{$}{$}', '$')
    store_matches('\frac{$}{$}')
    more_fractions = !!(/\\frac{/ =~ simplified_bracket_string)
    return fractions if more_fractions
    simplified_bracket_string

  end

  def store_matches(matched_string)
    @replaced_content << matched_string
  end

  def fraction_brackets
    first_bracket_string = extract_string_between_curly_bracket
    store_matches(first_bracket_string)
    first_bracket_string = '\frac'+first_bracket_string
    test = string.sub(first_bracket_string, '\frac$')
    string.sub!(first_bracket_string, '\frac$')
    second_bracket_string = extract_string_between_curly_bracket
    store_matches(second_bracket_string)
    string.sub!(second_bracket_string, '$')
    string.gsub!('\\frac$$', '\\frac{$}{$}')
  end

  def parentheses
    simplified_string = parentheses_content
    string.gsub!('($)','$')
    more_parentheses = !!(/\(/ =~ string)
    return parentheses if more_parentheses
    simplified_string
  end

  def parentheses_content
    inner_string = extract_string_from_outer_bracket
    string.sub!(inner_string, '($)')
  end

  def extract_string_from_outer_bracket
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


  def extract_string_between_curly_bracket
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
