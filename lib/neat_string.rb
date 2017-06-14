class String

  def objectify

    #assign self into expression_string
    expression_string = self
    #Does the expression need simplification?
    #If Not - return the string as the answer
    return expression_string unless expression_string.needs_simplification

    top_level_simplified_string
    #simplify the string into top level expression
    type_of_expression = classify(expression_string)
    # Class-name
    # Simplifier
    # Simplify.expression
    simplified_expression = simplify(expression_string)

    objectified_expression = objectify_expression(type_of_expression)
    if needs_further_simplification?(objectified_expression)
      recall_objectify(objectified_expression)
    else
      clean_expression_object_arguments(objectified_expression)
    end
    # simplifies the top level expression string into a string to be objectified
    # 1) Is it a power NA
    # 2)a) Is it a fraction:
    # Criteria: Starts with \frac, ends with }
    #Unsolved: how do you contain everything within a regex where there are multiple
    #Make a test string-> get the maximum length total match
    #b) Yes -> objectify the fraction -> Take everything
    #within curly brackets and add to Div object
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
    #4) Is it an addition?
    # Number next to a + but only if preceeded by something, 2+2
    # Letter => a+2, a+a
    # Number => 2+a, 2+2
    # Subtraction Cases
    # Letters => a-1, a-a
    # numbers => 1-1, 1-a
    #
    # If any of these criteria are met, simplify the expression]
    # into the an expression devoid of ambiguity
    # Ie. change everthing that would be bracketed into a unique character
    # Also store the replacements of the initial string
    #Obectify
    #There needs to be a separate method for each operand
    # It should only deal with strings that have no ambiguity in them
    # Ie. no mult expressions in an addition string

    # $ will be used as the replacement character for the time being
    # There will be no direct manipulation of the args inside the objects other
    # than the instantiation of the expression

    # At the end of an objectify_'expression'
    # Each argument should be checked, if any of them need to be further
    #simplified then they obejectify needs to be called recursively
    # If there is no need for further simplification then the arguments need to be
    # cleaned
  end


  def classify(string)
    #returns either div, mult, add, power
  end
  def objectify_addition(string)
    #returns an
  end

  def objectify_division

  end

  def objectify_multiplication

  end
end
