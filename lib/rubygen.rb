require 'rubygen/version'
require 'rubygen/automatic_indentation'

# RubyGen helps you generating Ruby code by indenting it for you.
class RubyGen
  include AutomaticIndentation

  def initialize
    @statements = []
    @level = 0
  end

  def code
    @statements.join("\n")
  end

  def << statement
    outdent if outdent?(statement)
    push statement
    indent if indent?(statement)
  end

  def blank
    push nil
  end

  def block statement
    push statement
    indent
  end

  def end modifier = nil
    outdent
    push(modifier ? "end #{modifier}" : 'end')
  end

  def left statement
    outdent
    push statement
    indent
  end

  protected

  def push statement
    if statement
      @statements << indentation + statement
    else
      @statements << ''
    end
  end

  def indentation
    '  ' * @level
  end

  def indent
    @level += 1
  end

  def outdent
    @level -= 1 if @level > 0
  end
end
