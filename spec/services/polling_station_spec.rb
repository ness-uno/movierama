require 'rails_helper'

RSpec.describe PollingStation do
  let(:the_voting_booth) { double('VotingBoth', vote: true) }
  let(:the_notifier) { double('Notifier', notify: true) }

  let(:user) { double('User') }
  let(:movie) { double('Movie') }
  let(:preference) { double('Preference') }

  before do
    allow(VotingBooth).to receive(:new).with(user, movie).and_return(the_voting_booth)
    allow(Notifier).to receive(:new).with(user: user, movie: movie).and_return(the_notifier)
  end

  subject { described_class.new(user: user, movie: movie) }

  it 'votes in the voting booth' do
    expect(the_voting_booth).to receive(:vote).with(preference)
    subject.vote(preference)
  end

  it 'notifies the user about the user preference' do
    expect(the_notifier).to receive(:notify).with(preference)
    subject.vote(preference)
  end
end
