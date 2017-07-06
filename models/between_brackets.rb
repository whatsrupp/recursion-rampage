# It extracts the string between two brackets and returns the string
class BetweenBrackets


  def initialize(left_bracket, right_bracket, string)
    @opening = left_bracket
    @closing = right_bracket
    @bracket_count = 0
    @match_indices = {}
    @string = string
  end

  def extract

    string.each_char.with_index do |char,index|
      if opening_bracket_match?(char)
        opening_updates(index)
      elsif closing_bracket_match?(char)
         closing_updates(index)
         return extract_string_from_brackets if @match_indices[:end]
      end
    end
    string
  end

  private
  attr_reader :bracket_count, :closing, :opening, :string

  def opening_updates(index)
    if open_or_closing_bracket?
      save_start_index(index)
    end
    increment_bracket_count
  end

  def closing_updates(index)
    decrement_bracket_count
    if open_or_closing_bracket?
      save_end_index(index)
    end
  end

  def extract_string_from_brackets
    string[@match_indices[:start]+1, length_of_match-1]
  end

  def length_of_match
    @match_indices[:end]- @match_indices[:start]
  end

  def save_start_index(index)
    @match_indices[:start] = index
  end

  def save_end_index(index)
    @match_indices[:end] = index
  end

  def increment_bracket_count
    @bracket_count += 1
  end

  def decrement_bracket_count
    @bracket_count -= 1
  end

  def opening_bracket_match?(char)
    char == opening
  end

  def closing_bracket_match?(char)
    char == closing
  end

  def open_or_closing_bracket?
    bracket_count == 0
  end

end
