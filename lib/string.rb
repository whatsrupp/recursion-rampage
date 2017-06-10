
class String
  def objectify

    # BIDMAS
    #EVALUATE FROM LEFT TO RIGHT
    #Subtraction Last

    #Returns everything clumped between plusses but not plusses
    add_regex = /[^\+]+/
    check_for_minuses=/-/
    #Returns only digits including minus digits
    digit_regex = /[\-|\d]/

    #
    minus_regex = /(?:\-.*?(?=-))|(?:\-.*)/
    # simpler minus_regex? /-?(\w+)/

    #Returns single letters and clumped digits both with or without negative
    mult_regex = /-?(?:\d+|\w)/

    #finds the \frac brackets needs to change to only count 2
    div_regex = /\\frac{.*}/
    #Finds everything between curly braces
    curly_extract_regex =/[^{]+(?=})/

    # negatives = !!/\-/.match(input)

    # assign input string into a variable
    string = self
    # remove plusses from string and return an array of each part
    # GOAL

    if !!(mult_regex =~ string)
      matched_content = string.scan(mult_regex)
      mult_equation_arguments = matched_content.join(', ')
      string = 'mult(' + mult_equation_arguments + ')'
    end

    if !!(/-/ =~ string)
      string.gsub!(/-/,'+-')
    end

    if !!(/\+/ =~ string)
      matched_content = string.scan(/[^\+]+/)

      add_equation_arguments = matched_content.join(', ')
      string = 'add(' + add_equation_arguments +')'

    end

    if !!(/[A-Za-z]/=~ string)
      # matchedContent = string.scan(/(?<=add\().+(?=\))/)
      string.gsub!(/[A-Za-z]/,'\'\0\'')
      string.gsub!("'a''d''d'",'add')
      string.gsub!("'m''u''l''t'",'mult')

    end

    eval(string)

    #
    # filter_out_plus = input.scan(add_regex)
    # if negatives
    #   quicktest = filter_out_plus.map! { |e|  !!/\-/.match(e)? e.scan(minus_regex) : e }.flatten!
    # end
    # filter_out_plus.map! { |entry|  entry.match(digit_regex) ?  entry.to_i : entry  }
    #
    # add(filter_out_plus)
  end

end
