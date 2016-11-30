require 'rails_helper'

RSpec.describe Notifier do

  let(:movie) { double('Movie', name: 'Matrix', user: recipient) }
  let(:recipient) { double('User', email: 'test@example.com', name: 'Mario') }

  let(:user) { double('User', name: 'Luigi') }

  subject { described_class.new(user: user, movie: movie ) }

  describe '#notify' do
    let(:email_params) { double('EmailParams') }
    let(:action) { :like }

    before do
      allow(LikeHateEmailParams).to receive(:build)
      .with(user: user, movie: movie, action: action)
      .and_return(email_params)
    end

    context 'when an user likes a movie' do
      it 'adds a like email to the queue' do
        expect(LikeHateEmailWorker).to receive(:perform_async).with(email_params)
        subject.notify(action)
      end
    end

    context 'when an user does not like a movie' do
      let(:action) { :hate }
      it 'adds a hate email to the queue' do
        expect(LikeHateEmailWorker).to receive(:perform_async).with(email_params)
        subject.notify(action)
      end
    end
  end
end
