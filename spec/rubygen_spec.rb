require 'spec_helper'

describe RubyGen do
  it 'has a version number' do
    expect(RubyGen::VERSION).not_to be nil
  end

  let(:rubygen) { subject }
  let(:code) { subject.code }

  context 'without any statements' do
    it 'generates no code' do
      expect(rubygen.code).to eq('')
    end
  end

  context 'with one statement' do
    it 'generates one line of code' do
      rubygen << 'exit'

      expect(rubygen.code).to eq('exit')
    end
  end

  context 'with multiple statements' do
    it 'generates multiple lines of code' do
      rubygen << 'p self'
      rubygen << 'exit'

      expect(rubygen.code).to eq(<<-RUBY.chomp)
p self
exit
      RUBY
    end
  end

  context 'with a blank line inside a block' do
    it 'generates multiple lines of code' do
      rubygen.block 'if free?'
      rubygen << 'take_it'
      rubygen.blank
      rubygen << 'drink'
      rubygen.end

      expect(rubygen.code).to eq(<<-RUBY.chomp)
if free?
  take_it

  drink
end
      RUBY
    end
  end

  context 'with an if block' do
    it 'handles indentation' do
      rubygen.block 'if happy?'
      rubygen << 'laugh'
      rubygen.end

      expect(rubygen.code).to eq(<<-RUBY.chomp)
if happy?
  laugh
end
      RUBY
    end
  end

  context 'with a case block' do
    it 'handles indentation' do
      rubygen.block 'case country'
      rubygen.left 'when Germany'
      rubygen << 'drink :beer'
      rubygen.left 'when France'
      rubygen << 'drink :wine'
      rubygen.end

      expect(rubygen.code).to eq(<<-RUBY.chomp)
case country
when Germany
  drink :beer
when France
  drink :wine
end
      RUBY
    end
  end

  context 'with a block and a modifier' do
    it 'handles indentation' do
      rubygen.block 'begin'
      rubygen << 'drink :beer'
      rubygen.end 'if sad?'

      expect(rubygen.code).to eq(<<-RUBY.chomp)
begin
  drink :beer
end if sad?
      RUBY
    end
  end
end
