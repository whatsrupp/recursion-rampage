#takes in a string, returns objectified addition object

class ObjectifyMultiplication < Objectify


  def objectify

    simplified = simplify_expression

    string = simplified[:expression]
    matches = simplified[:matches]

    string.sub!(/-/, '-1') if (string =~ /-[a-zA-Z$£]/) == 0
    mult_args_regex = /-?[a-zA-Z$£]|-?[0-9]+/
    mult_equation_args = string.scan(mult_args_regex)

    mult_equation_args = resubstitute_args(mult_equation_args, matches)
    mult_expression = mtp(mult_equation_args)
    return mult_expression

  end
end
