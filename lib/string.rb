
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

    minus_regex = /(?:\-.*?(?=-))|(?:\-.*)/
    # simpler minus_regex? /-?(\w+)/

    #Returns single letters and clumped digits both with or without negative
    mult_regex = /-?(?:\d+|\w|\$)/
    mult_filter_regex = /(\([^\)]+\)+)/
    non_bracket_mult_regex = /(?:[0-9]+[a-zA-Z](?:[\w]*))|(?:[a-zA-Z]+[0-9]+(?:[\w]*))/
    #finds the \frac brackets needs to change to only count 2
    div_regex = /\\frac{.*}/
    #Finds everything between curly braces
    between_curly_regex =/[^{]+(?=})/
    between_parentheses_regex = /\(([^\)]+)\)/
    between_frac_regex = /\{([^\}]+)\}/
    initial_regex = /(\{[^\}]+\})|(\([^\)]+\))/
    # negatives = !!/\-/.match(input)

    # assign input string into a variable
    string = self

    # remove plusses from string and return an array of each part
    # GOAL
    output = nil
    if needs_simplification(string)
      #scans through and looks for brackets and curlys
      string.gsub!(non_bracket_mult_regex, '(\0)')
      matched_content = string.scan(initial_regex)
      matched_content.flatten!
      matched_content.compact!
      #[array, of, the matches]
      unique_substitution = '$'
      #substitute all those matches for dollars
      dummy_string = string.gsub(initial_regex, unique_substitution)
      test1 = needs_add_simplification(dummy_string)
      test2 = !!(initial_regex =~ string)
      # if needs_add_simplification(dummy_string) && !!(initial_regex =~ dummy_string)
      if test1 && test2
        dummy_string.gsub!(/-/,'+-')
        arguments = dummy_string.scan(/[^\+]+/)
        add_expression = add(arguments)
        add_expression.args.each_with_index do |string, i|
          if /\$/ =~ add_expression.args[i]
            add_expression.args[i]=string.gsub!(/\$/) { |substring| matched_content.shift }
          end
        end
        return recall_objectify(add_expression)
      end



      if needs_div_simplification(string)
        matched_content = string.scan(between_curly_regex)
        #
        div_expression = div(matched_content)
        # div_equation_arguments = matched_content.join(', ')
        # string = 'div(' + div_equation_arguments + ')'
        return recall_objectify(div_expression)
      end

      if needs_mult_simplification(string)
        inside_brackets = string.scan(mult_filter_regex).flatten
        dummy_string = string.gsub(mult_filter_regex, unique_substitution)
#If there is only 1 dollar sign
        if (dummy_string.length == 1 && !!(/\$/ =~ dummy_string))||(dummy_string.length == 2 && !!(/-\$/ =~ dummy_string))
          no_more_simplification_string = string.gsub!(/[()]/,'')
          matched_content = no_more_simplification_string.scan(mult_regex)
        else
          matched_content = dummy_string.scan(mult_regex)
        end

        mult_equation_arguments = matched_content.join("', '")
        if  /(-)[a-zA-Z$]/ =~ mult_equation_arguments
          mult_equation_arguments.gsub!(/-(?=[a-zA-Z$])/, '\01\', \'')
        end

        mult_equation_arguments.gsub!(/\$/) do |dollar|
          replacement = inside_brackets.shift
          # final = replacement.scan(mult_regex)
          # replacement = final.join("', '")
        end
        string = "mtp('" + mult_equation_arguments + "')"

        return recall_objectify(eval(string))
      end

      if needs_add_simplification(string)
        string.gsub!(/[()]/,'')
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
  def top_level_function

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
