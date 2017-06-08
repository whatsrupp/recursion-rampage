
class String
  def objectify
    input = self
    isAddedRegex = /[^\+]+/
    filtered = input.scan(isAddedRegex)
    isDigitRegex = /[\-|\d]/
    filtered.map! { |entry|  entry.match(isDigitRegex) ?  entry.to_i : entry  }
    add(filtered)
  end


  
end
