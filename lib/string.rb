
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
    expression = [string]

    # remove plusses from string and return an array of each part
    # GOAL
    output = nil
    if needs_simplification(string)
      if needs_div_simplification(string)
        matched_content = string.scan(curly_extract_regex)
        div_expression = div(matched_content)
        # div_equation_arguments = matched_content.join(', ')
        # string = 'div(' + div_equation_arguments + ')'
        return recall_objectify(div_expression)
      end

      if needs_mult_simplification(string)
        matched_content = string.scan(mult_regex)
        mult_equation_arguments = matched_content.join("', '")

        if  /(-)[a-zA-Z]/ =~ mult_equation_arguments
          mult_equation_arguments.gsub!(/-(?=[a-zA-Z])/, '\01\', \'')
        end

        string = "mtp('" + mult_equation_arguments + "')"

        return recall_objectify(eval(string))
      end

      if needs_add_simplification(string)
        string.gsub!(/-/,'+-')
        matched_content = string.scan(/[^\+]+/)
        add_expression = add(matched_content)
        # add_equation_arguments = matched_content.join(', ')
        # string = 'add(' + add_equation_arguments +')'
        return recall_objectify(add_expression)
      end
    else
      return string
    end

  end

  def recall_objectify (expression)
    expression.args.each_with_index do |string, i|
      if needs_simplification(string)
        expression.args[i] = string.objectify
      else
        expression.args[i]= string.to_i if /\d/=~string
      end
    end
    return expression
  end

end
