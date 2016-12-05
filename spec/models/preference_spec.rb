require 'rails_helper'

RSpec.describe Preference do
  describe '.for' do
    context 'with an invalid preference' do
      it 'raises an ArgumentError' do
        expect{described_class.for('mmm')}.to raise_error(ArgumentError, '`mmm` is not valid preference')
      end
    end

    context 'with a valid preference' do
      let(:preference) { :like }

      subject { described_class.for(preference) }

      it 'set the preference' do
        expect(subject).to be_a(Preference)
      end
    end
  end

  describe '#like?' do
    subject { described_class.for(:like).like? }

    it { expect(subject).to eq(true) }
  end

  describe '#hate?' do
    subject { described_class.for(:hate).hate? }

    it { expect(subject).to eq(true) }
  end

end
