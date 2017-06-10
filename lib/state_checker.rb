module StateChecker


  def needs_add_simplification(string)
    regex = /\+/
    !string.scan(regex).empty?
  end
end
