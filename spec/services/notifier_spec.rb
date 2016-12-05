require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Notifier do

  let(:movie) { double('Movie', name: 'Matrix', user: recipient) }
  let(:recipient) { double('User', email: 'test@example.com', name: 'Mario') }

  let(:user) { double('User', name: 'Luigi') }

  subject { described_class.new(user: user, movie: movie ) }

  describe '#notify' do
    let(:job_args) { {"key" => "value"} }
    let(:email_params) { double('EmailParams', to_json: job_args.to_json ) }
    let(:preference) { double('Preference') }

    before do
      Sidekiq::Worker.clear_all
      allow(PreferenceEmailParams).to receive(:build)
      .with(user: user, movie: movie, preference: preference)
      .and_return(email_params)
    end

    it 'adds a like email to the queue' do
      expect{subject.notify(preference)}.to change{PreferenceEmailWorker.jobs.size}.by(1)

      job = PreferenceEmailWorker.jobs.last
      expect(job['args']).to include(job_args)
    end
  end
end
