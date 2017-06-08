
class String
  def objectify
    input = self
    add_regex = /[^\+]+/
    digit_regex = /[\-|\d]/
    minus_regex = /(?:\-.*?(?=-))|(?:\-.*)/

    negatives = !!/\-/.match(input)

    filter_out_plus = input.scan(add_regex)
    if negatives
      quicktest = filter_out_plus.map! { |e|  !!/\-/.match(e)? e.scan(minus_regex) : e }.flatten!
    end
    filter_out_plus.map! { |entry|  entry.match(digit_regex) ?  entry.to_i : entry  }

    add(filter_out_plus)
  end





end
