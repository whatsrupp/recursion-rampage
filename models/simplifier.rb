#Take an expression string and replace the top level parentheses and  fractions with
#unique symbols
class Simplify


  attr_reader :replaced_content
  attr_reader :string

  def initialize (string)
    @replaced_content = {
      fractions: [],
      parentheses: []
    }
    @initial_string = string.dup
    @string = string
  end

  def expression
    string_search
  end

  def string_search
    @string.each_char do |character|
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
    simplified_bracket_string.gsub!('\frac{$}{$}', "£")
    simplified_bracket_string
  end

  def store_matches(matched_string,type)
    if type == '\\'
      @replaced_content[:fractions] << matched_string
    elsif type == '('
      @replaced_content[:parentheses] << matched_string
    end
  end

  def fraction_brackets
    first_bracket_string = between_curlies(string).extract
    store_matches(first_bracket_string,'\\')
    first_bracket_string = '\frac{'+first_bracket_string+'}'
    string.sub!(first_bracket_string, '\frac$')

    second_bracket_string = between_curlies(string).extract
    store_matches(second_bracket_string, '\\')
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
    inner_string = between_parentheses(string).extract
    store_matches(inner_string, '(')
    bracketed_string = '('+inner_string+')'
    string.sub!(bracketed_string, '$')
  end

end
