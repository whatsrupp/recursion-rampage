#superclass from objectify classes
class Objectify

  def initialize(string)
    @string = string
  end

  def simplify_expression
    string = @string.dup
    simplify = Simplify.new(string)
    simplified_expression = simplify.expression
    replaced_content = simplify.replaced_content
    output = {
      expression: simplified_expression,
      matches: replaced_content
    }
    return output
  end

  def resubstitute_args(expression_args, matches)
    expression_args.each_with_index do |string, i|
      expression_args[i].gsub!(/\£/) {  '\frac{$}{$}'  }
      expression_args[i].gsub!(/\{\$\}/) {  '{'+matches[:parentheses].shift+'}'  }
      expression_args[i].gsub!(/\$/) {  '('+matches[:parentheses].shift+')'  }
    end
  end

end
