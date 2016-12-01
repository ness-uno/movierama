require 'rails_helper'

RSpec.describe Notifier do

  let(:movie) { double('Movie', name: 'Matrix', user: recipient) }
  let(:recipient) { double('User', email: 'test@example.com', name: 'Mario') }

  let(:user) { double('User', name: 'Luigi') }

  subject { described_class.new(user: user, movie: movie ) }

  describe '#notify' do
    let(:email_params) { double('EmailParams') }
    let(:preference) { double('Preference') }

    before do
      allow(PreferenceEmailParams).to receive(:build)
      .with(user: user, movie: movie, preference: preference)
      .and_return(email_params)
    end

    it 'adds a like email to the queue' do
      expect(PreferenceEmailWorker).to receive(:perform_async).with(email_params)
      subject.notify(preference)
    end
  end
end
