require 'rails_helper'

RSpec.describe UserMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  let(:vote) { :like }
  let(:preference) { double('Preference', vote: vote) }

  let(:email_params) do
    double('LikeHateEmailParams',
      recipient_email: 'test@example.com',
      recipient_name: 'Mario',
      user_name: 'Luigi',
      movie_title: 'Super Mario Bros.',
      preference: preference,
    )
  end

  subject do
    described_class.preference_email(email_params)
  end

  it { expect(subject).to deliver_to(email_params.recipient_email) }

  it { expect(subject).to deliver_from('from@example.com') }

  describe '#preference_email' do
    context 'when an user likes a movie' do

      it { expect(subject).to have_subject('Find out who likes your movie') }

      it { expect(subject).to have_body_text(/Hi #{email_params.recipient_name}/) }

      it { expect(subject).to have_body_text(/#{email_params.user_name} really likes `#{email_params.movie_title}`/) }
    end

    context 'when an user hates a movie' do
      let(:vote) { :hate }

      it { expect(subject).to have_subject('Find out who hates your movie') }

      it { expect(subject).to have_body_text(/Hi #{email_params.recipient_name}/) }

      it { expect(subject).to have_body_text(/#{email_params.user_name} really hates `#{email_params.movie_title}`/) }
    end

  end

end
