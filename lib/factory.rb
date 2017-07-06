# Module for creating disposable class instances
module Factory
  def add(*args)
    Addition.new(*args)
  end

  def sbt(*args)
    Subtraction.new(*args)
  end

  def mtp(*args)
    Multiplication.new(*args)
  end

  def div(*args)
    Division.new(*args)
  end

  def pow(*args)
    Power.new(*args)
  end

  def between_parentheses(string)
    BetweenBrackets.new('(',')',string)
  end

  def between_curlies(string)
    BetweenBrackets.new('{','}', string)
  end

  def objectify_addition(string)
    ObjectifyAddition.new(string).objectify
  end

  def objectify_multiplication(string)
    ObjectifyMultiplication.new(string).objectify
  end

  def objectify_division(string)
    ObjectifyDivision.new(string).objectify
  end

  def simplify_expression(input_string)
    string = input_string.dup
    simplify = Simplify.new(string)
    simplified_expression = simplify.expression
    replaced_content = simplify.replaced_content
    output = {
      expression: simplified_expression,
      matches: replaced_content
    }
    return output
  end



end
