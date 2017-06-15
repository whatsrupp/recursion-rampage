class String


  def objectify
    if needs_div_simplification?
      div = objectify_division(self)
      return callback_objectify(div)
    end

    if needs_add_simplification?
      add = objectify_addition(self)
      return callback_objectify(add)
    end

    if needs_mult_simplification?
      mult = objectify_multiplication(self)
      return callback_objectify(mult)
    end
  end

  def needs_simplification?(input_expression)
    string=input_expression.dup
    div  = string.needs_div_simplification?
    mult = string.needs_mult_simplification?
    add = string.needs_add_simplification?
    div||add||mult
  end

  def needs_div_simplification?
    simplified = simplify_expression(self)
    simplified[:expression] == "£"
  end

  def needs_mult_simplification?
    simplified = simplify_expression(self)
    string = simplified[:expression]
    leading_minus_mult = (string =~ /-[a-zA-Z$£]/) == 0
    string.gsub!(/-/,'+-')
    mult_regex = /(?:-?[0-9]+[a-zA-Z£$](?:[\w]*))|(?:-?[a-zA-Z£$]+[0-9]+(?:[\w]*))|(?:-?[a-zA-Z$£][a-zA-Z£$]+(?:[\w]*))|-[a-zA-Z$£]/
    any_matches = !string.scan(mult_regex).empty?
  end

  def needs_add_simplification?
    simplified = simplify_expression(self)
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
    internal_string = between_parentheses(string).extract
    simplified = simplify.expression

    if simplified == '$'
      return internal_string
    end
    string
  end

end
