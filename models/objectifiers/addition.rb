#takes in a string, returns objectified addition object
class ObjectifyAddition < Objectify

  def objectify
    simplified = simplify_expression

    simplified_string = simplified[:expression]
    matches = simplified[:matches]

    simplified_string.gsub!(/-/,'+-')
    add_equation_args = simplified_string.scan(/[^\+]+/)

    add_equation_args = resubstitute_args(add_equation_args, matches)
    add_expression = add(add_equation_args)

    return add_expression

  end
end
