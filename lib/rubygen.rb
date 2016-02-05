require 'rubygen/version'

class RubyGen
  def initialize
    @statements = []
    @level = 0
  end

  def code
    @statements.join("\n")
  end

  def << statement
    @statements << indentation + statement
  end

  def blank
    @statements << ''
  end

  def block statement
    self << statement
    @level += 1
  end

  def end modifier = nil
    @level -= 1

    self << (modifier ? "end #{modifier}" : 'end')
  end

  def left statement
    @level -= 1
    self << statement
    @level += 1
  end

  protected
  
  def indentation
    '  ' * @level
  end
end
