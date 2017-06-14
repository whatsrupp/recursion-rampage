class String


  def objectify
    if needs_add_simplification?
      add = objectify_addition
      return add
    end
    if needs_mult_simplification?
      mult = objectify_multiplication

      return mult
    end
  end

  def objectify_multiplication
    string = self.dup
    string.sub!(/-/, '-1') if (string =~ /-[a-zA-Z]/) == 0
    mult_args_regex = /-?[a-zA-Z$£]|-?[0-9]+/
    mult_equation_args = string.scan(mult_args_regex)
    cleaned_args = clean_args(mult_equation_args)
    mult_expression = mtp(cleaned_args)
    return mult_expression
  end

  def needs_div_simplification?
    simplify = Simplify.new(self)
    simplify.expression == "£"
  end

  def needs_mult_simplification?
    string = self.dup
    leading_minus_mult = (string =~ /-[a-zA-Z$£]/) == 0
    string.gsub!(/-/,'+-')
    mult_regex = /(?:-?[0-9]+[a-zA-Z](?:[\w]*))|(?:-?[a-zA-Z]+[0-9]+(?:[\w]*))|(?:-?[a-zA-Z$£][a-zA-Z£$]+(?:[\w]*))|-[a-zA-Z$£]/
    any_matches = !string.scan(mult_regex).empty?
  end

  def needs_add_simplification?
    string = self.dup
    string.sub!(/-/, '') if (string =~ /-/) == 0
    string.gsub!(/-/,'+-')
    string.gsub!(mult_regex = /(?:-?[0-9]+[a-zA-Z](?:[\w]*))|(?:-?[a-zA-Z]+[0-9]+(?:[\w]*))|(?:-?[a-zA-Z$£][a-zA-Z£$]+(?:[\w]*))/, '$')
    add_regex = /\+/
    a_match = !!( add_regex =~ string)
  end

  def objectify_addition
    string = self.dup
    string.gsub!(/-/,'+-')
    add_equation_args = string.scan(/[^\+]+/)
    cleaned_args = clean_args(add_equation_args)
    add_expression = add(cleaned_args)
    # return recall_objectify(add_expression)
  end

  def clean_args(arg_array)
    arg_array.each_with_index do |string, i|
      arg_array[i] = string.to_i if !!(/\d/=~string)
    end
  end

end
