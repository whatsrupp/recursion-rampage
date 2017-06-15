#takes in a string, returns objectified division object

class ObjectifyDivision < Objectify
  def objectify
    simplified = simplify_expression
    division_args = simplified[:matches][:fractions]

    div_expression = div(division_args)
    return div_expression
  end
end
