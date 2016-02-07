require 'spec_helper'

describe RubyGen do
  let(:rubygen) { subject }
  let(:code) { rubygen.code }

  describe 'automatic indentation' do
    context 'with a block' do
      it 'handles indentation' do
        rubygen << 'Europe.trip do |trip|'
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
        rubygen << 'if happy?'
        rubygen << 'laugh'
        rubygen << 'end'

        expect(code).to eq(<<-RUBY.chomp)
if happy?
  laugh
end
        RUBY
      end
    end

    context 'with a case block' do
      it 'handles indentation' do
        rubygen << 'case country'
        rubygen << 'when Germany'
        rubygen << 'drink :beer'
        rubygen << 'when France'
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
        rubygen << 'begin'
        rubygen << 'drink :beer'
        rubygen << 'end if sad?'

        expect(code).to eq(<<-RUBY.chomp)
begin
  drink :beer
end if sad?
        RUBY
      end
    end
  end
end
