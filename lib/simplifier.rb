class Simplify

  #Take an expression string and replace the top level parentheses and  fractions with
  #unique symbols

  attr_reader :replaced_content
  attr_reader :string

  def initialize (string)
    @replaced_content = []
    @initial_string = string.dup
    @string = string
  end

  def expression
    string_search
  end

  def string_search
    @string.each_char do |character|
      p character
      if character == '\\'
        fractions
        string_search
        break
      elsif character == '('
        parentheses
        string_search
        break
      end
    end
    return string
  end

  def fractions
    simplified_bracket_string = fraction_brackets
    simplified_bracket_string.gsub!('\frac{$}{$}', '$')
    simplified_bracket_string
  end

  def store_matches(matched_string)
    @replaced_content << matched_string
  end

  def fraction_brackets
    first_bracket_string = extract_string_between('{','}')
    store_matches(first_bracket_string)
    first_bracket_string = '\frac{'+first_bracket_string+'}'
    string.sub!(first_bracket_string, '\frac$')

    second_bracket_string = extract_string_between('{','}')
    store_matches(second_bracket_string)
    second_bracket_string = '{'+second_bracket_string+'}'
    string.sub!(second_bracket_string, '$')

    string.gsub!('\\frac$$', '\\frac{$}{$}')
  end

  def parentheses
    simplified_string = parentheses_content
    string.gsub!('($)','$')
    more_parentheses = !!(/\(/ =~ string)
    simplified_string
  end

  def parentheses_content
    inner_string =extract_string_between('(',')')
    bracketed_string = '('+inner_string+')'
    string.sub!(bracketed_string, '($)')
  end

  def extract_string_between(left_character, right_character)
    bracket_count = 0
    bracket_start_index = nil

    string.each_char.with_index do |char,index|
      if (char==left_character)
        if bracket_count == 0
          bracket_start_index = index
        end
        bracket_count += 1
      end
      if (char==right_character)
        bracket_count-=1
        if bracket_count == 0
          bracket_end_index = index
          length = bracket_end_index - bracket_start_index
          bracket_string = string[bracket_start_index+1,bracket_end_index-bracket_start_index-1]
          return bracket_string
        end
      end
    end
    return string
  end

end
