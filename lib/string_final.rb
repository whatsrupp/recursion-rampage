class String


  def objectify
    if needs_div_simplification?
      div = objectify_division
      return callback_objectify(div)
    end

    if needs_add_simplification?
      add = objectify_addition
      return callback_objectify(add)
    end

    if needs_mult_simplification?
      mult = objectify_multiplication
      return callback_objectify(mult)
    end
  end

  def objectify_division
    simplified = simplify_expression
    division_args = simplified[:matches]

    div_expression = div(division_args)
    p div_expression
    return div_expression
  end

  def objectify_addition
    simplified = simplify_expression
    string = simplified[:expression]
    matches = simplified[:matches]
    string.gsub!(/-/,'+-')
    add_equation_args = string.scan(/[^\+]+/)
    add_equation_args.each_with_index do |string, i|
      # add_equation_args[i].gsub!(/\£/) {  '\frac{$}{$}'  }
      add_equation_args[i].gsub!(/\$/) {  '('+matches.shift+')'  }
    end
    add_expression = add(add_equation_args)
    p add_expression

    return add_expression

    # return recall_objectify(add_expression)
  end

  def simplify_expression
    string = self.dup
    simplify = Simplify.new(string)
    simplified_expression = simplify.expression
    replaced_content = simplify.replaced_content
    output = {
      expression: simplified_expression,
      matches: replaced_content
    }
    return output
  end

  def objectify_multiplication
    simplified = simplify_expression
    string = simplified[:expression]
    matches = simplified[:matches]

    string.sub!(/-/, '-1') if (string =~ /-[a-zA-Z]/) == 0
    mult_args_regex = /-?[a-zA-Z$£]|-?[0-9]+/
    mult_equation_args = string.scan(mult_args_regex)
    mult_equation_args.each_with_index do |string, i|
      # add_equation_args[i].gsub!(/\£/) {  '\frac{$}{$}'  }
      mult_equation_args[i].gsub!(/\$/) {  '('+matches.shift+')'  }
    end
    mult_expression = mtp(mult_equation_args)
    p mult_expression
    return mult_expression
  end

  def needs_simplification?(input_expression)
    string=input_expression.dup
    div  = string.needs_div_simplification?
    mult = string.needs_mult_simplification?
    add = string.needs_add_simplification?
    div||add||mult
  end

  def needs_div_simplification?
    simplified = simplify_expression
    simplified[:expression] == "£"
  end

  def needs_mult_simplification?
    simplified = simplify_expression
    string = simplified[:expression]
    leading_minus_mult = (string =~ /-[a-zA-Z$£]/) == 0
    string.gsub!(/-/,'+-')
    mult_regex = /(?:-?[0-9]+[a-zA-Z£$](?:[\w]*))|(?:-?[a-zA-Z£$]+[0-9]+(?:[\w]*))|(?:-?[a-zA-Z$£][a-zA-Z£$]+(?:[\w]*))|-[a-zA-Z$£]/
    any_matches = !string.scan(mult_regex).empty?
  end

  def needs_add_simplification?
    simplified = simplify_expression
    string = simplified[:expression]
    string.sub!(/-/, '') if (string =~ /-/) == 0
    string.gsub!(/-/,'+-')
    string.gsub!(mult_regex = /(?:-?[0-9]+[a-zA-Z](?:[\w]*))|(?:-?[a-zA-Z]+[0-9]+(?:[\w]*))|(?:-?[a-zA-Z$£][a-zA-Z£$]+(?:[\w]*))/, '$')
    add_regex = /\+/
    a_match = !!( add_regex =~ string)
  end


  def clean_args(arg_array)
    arg_array.each_with_index do |string, i|
      arg_array[i] = string.to_i if !!(/\d/=~string)
    end
  end

  def callback_objectify(expression)
    expression.args.each_with_index do |string, i|
      p string
      if needs_simplification(string)
        string = remove_external_parentheses_when_required(string)
        expression.args[i] = string.objectify
      else
        expression.args[i]= string.to_i if /\d/=~string
      end
    end
    return expression
  end

  def remove_external_parentheses_when_required(input_expression)

    string = input_expression.dup
    simplify = Simplify.new(string.dup)
    #this is order dependent
    internal_string = simplify.extract_string_between('(',')')
    simplified = simplify.expression
    matches = simplify.replaced_content

    if simplified == '$'
      return internal_string
    end
    string
  end

end
