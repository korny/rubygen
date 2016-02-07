require 'spec_helper'

describe RubyGen do
  it 'has a version number' do
    expect(RubyGen::VERSION).not_to be nil
  end

  context 'without any statements' do
    it 'generates no code' do
      expect(RubyGen.new.code).to eq('')
    end
  end
end
