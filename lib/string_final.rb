class String


  def objectify
    objectify_addition
  end

  def objectify_addition

    self.gsub!(/-/,'+-')
    add_equation_args = self.scan(/[^\+]+/)
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
