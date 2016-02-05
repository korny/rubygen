class RubyGen
  module AutomaticIndentation
    LEFT_KEYWORDS = %w(
      else elsif when rescue ensure
    )

    INDENT_KEYWORDS = %w(
      begin
      if unless case
      for until while
      module class def
    ) + LEFT_KEYWORDS

    INDENT = /
      \A \s*
      #{Regexp.union INDENT_KEYWORDS} \b
      |
      (?: do | \{ ) (?: \s* \| [^\|\#]+ \|)? (?: \s* \# .*)? \z
    /x

    OUTDENT_KEYWORDS = %w(
      end
    ) + LEFT_KEYWORDS

    OUTDENT = /
      \A \s*
      #{Regexp.union OUTDENT_KEYWORDS} \b
    /x

    protected

    def indent? statement
      INDENT === statement
    end

    def outdent? statement
      OUTDENT === statement
    end
  end
end
