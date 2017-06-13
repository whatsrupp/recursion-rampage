module Classifier

  def classify(expression_string)
    return :pow if power_expression?(expression_string)
    return :div if division_expression?(expression_string)
    return :mult if multiplication_expression?(expression_string)
    return :add if addition_expression?(expression_string)
  end


  def power_expression?(expression_string)
    false
  end

  def division_expression?(expression_string)
    # Criteria: Starts with \frac, ends with }
    #Unsolved: how do you contain everything within a regex where there are multiple
    #Make a test string-> get the maximum length total match

    #starts with \frac{
    starting_frac_reg = /^\\frac{/
    starts_with_frac = !!(starting_frac_reg =~ expression_string)
    #ends with }
    ending_curly_reg = /}$/
    ends_with_curly_bracket = !!(ending_curly_reg =~ expression_string)
    #Greedily consume the entire expression:
    #Capture group is only between the two outermost curly brackets
    between_curly_reg = /\\frac{(.+)}/
    #Work Recursively to see if there is not a division involved
    frac_covers_entire_expression = true
    #Not sure how to do this properly but would need to be included if expanded

    starts_with_frac || ends_with_curly_bracket || frac_covers_entire_expression
  end

  def multiplication_expression?(expression_string)
    #3) Is it a Multiplication?
    # Criteria:
    # Letter next to number: a2
    # multiple letters: aa2, ab3
    # number next to letter: 2a
    # multi-digit number and letter: 22a
    # combination: 22a22b
    # optional minus sign: -a2 / -a2
    # number or letter next to brackets a(), 2()
    # with optional minus -a(), 2()

  end

  def addition_expression?(expression_string)
    false
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
          bracket_string = string[bracket_start_index+1,bracket_end_index-bracket_start_index-1]
          # output = {
          #   bracket_string: bracket_string,
          #   start_index: bracket_start_index,
          #   end_index: bracket_end_index
          # }
          return bracket_string
        end
      end
    end
    return string

  end
end
