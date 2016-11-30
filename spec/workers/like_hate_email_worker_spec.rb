require 'rails_helper'

RSpec.describe LikeHateEmailWorker do
  describe '#perform' do
    let(:email_params) { double('EmailParams') }
    let(:mailer) { double('Mailer', deliver: 'OK') }

    before { allow(UserMailer).to receive(:like_hate_email).with(email_params).and_return(mailer) }

    it 'delivers a like_email' do
      expect(mailer).to receive(:deliver).and_return('OK')
      subject.perform(email_params)
    end
  end
end
