require 'rails_helper'

RSpec.describe UserMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  let(:action) { :like }

  let(:email_params) do
    double('LikeHateEmailParams',
      recipient_email: 'test@example.com',
      recipient_name: 'Mario',
      user_name: 'Luigi',
      movie_name: 'Super Mario Bros.',
      action: action,
    )
  end

  subject do
    described_class.like_hate_email(email_params)
  end

  it { expect(subject).to deliver_to(email_params.recipient_email) }

  it { expect(subject).to deliver_from('from@example.com') }

  context 'with an invalid action' do
    let(:action) { :non_valid_action }

    it 'raises an ArgumentError if a not valid action is provided' do
      expect{ subject }.to raise_error(ArgumentError, '`non_valid_action` is not a valid action')
    end
  end

  describe '#like_hate_email' do
    context 'when an user likes a movie' do

      it { expect(subject).to have_subject('Find out who likes your movie') }

      it { expect(subject).to have_body_text(/Hi #{email_params.recipient_name}/) }

      it { expect(subject).to have_body_text(/#{email_params.user_name} really likes `#{email_params.movie_name}`/) }
    end

    context 'when an user hates a movie' do
      let(:action) { :hate }

      it { expect(subject).to have_subject('Find out who hates your movie') }

      it { expect(subject).to have_body_text(/Hi #{email_params.recipient_name}/) }

      it { expect(subject).to have_body_text(/#{email_params.user_name} really hates `#{email_params.movie_name}`/) }
    end

  end

end
