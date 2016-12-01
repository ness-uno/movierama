require 'rails_helper'

RSpec.describe LikeHateEmailWorker do
  describe '#perform' do
    let(:json_params) { "{}" }
    let(:email_params) { double('EmailParams') }
    let(:mailer) { double('Mailer', deliver: 'OK') }

    before do
      allow(LikeHateEmailParams).to receive(:from_json).with(json_params).and_return(email_params)
      allow(UserMailer).to receive(:like_hate_email).with(email_params).and_return(mailer)
    end

    it 'delivers a like_email' do
      expect(mailer).to receive(:deliver).and_return('OK')
      subject.perform(json_params)
    end
  end
end
