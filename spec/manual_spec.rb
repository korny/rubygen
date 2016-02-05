require 'spec_helper'

describe RubyGen do
  let(:rubygen) { subject }
  let(:code) { rubygen.code }

  describe 'manual indentation' do
    context 'with one statement' do
      it 'generates one line of code' do
        rubygen << 'exit'

        expect(code).to eq('exit')
      end
    end

    context 'with multiple statements' do
      it 'generates multiple lines of code' do
        rubygen << 'p self'
        rubygen << 'exit'

        expect(code).to eq(<<-RUBY.chomp)
p self
exit
        RUBY
      end
    end

    context 'with a block' do
      it 'handles indentation' do
        rubygen.block 'Europe.trip do |trip|'
        rubygen << 'trip.visit Italy'
        rubygen.end

        expect(code).to eq(<<-RUBY.chomp)
Europe.trip do |trip|
  trip.visit Italy
end
        RUBY
      end
    end

    context 'with an if block' do
      it 'handles indentation' do
        rubygen.block 'if happy?'
        rubygen << 'laugh'
        rubygen.end

        expect(code).to eq(<<-RUBY.chomp)
if happy?
  laugh
end
        RUBY
      end
    end

    context 'with a blank line inside an if block' do
      it 'generates multiple lines of code' do
        rubygen.block 'if free?'
        rubygen << 'take_it'
        rubygen.blank
        rubygen << 'drink'
        rubygen.end

        expect(code).to eq(<<-RUBY.chomp)
if free?
  take_it

  drink
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

        expect(code).to eq(<<-RUBY.chomp)
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

        expect(code).to eq(<<-RUBY.chomp)
begin
  drink :beer
end if sad?
        RUBY
      end
    end

    context 'negative indent' do
      it 'is ignored' do
        rubygen.end
        rubygen << 'end'

        expect(code).to eq(<<-RUBY.chomp)
end
end
        RUBY
      end
    end
  end
end
