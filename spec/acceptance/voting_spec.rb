require 'rails_helper'
require 'capybara/rails'
require 'support/pages/movie_list'
require 'support/pages/movie_new'
require 'support/with_user'
require 'sidekiq/testing'

RSpec.describe 'vote on movies', type: :feature do

  let(:page) { Pages::MovieList.new }
  let(:author) do
    User.create(
      uid:  'null|12345',
      name: 'Bob',
      email: 'testxx@example.com'
    )
  end

  before do
    Movie.create(
      title:        'Empire strikes back',
      description:  'Who\'s scruffy-looking?',
      date:         '1980-05-21',
      user:         author
    )
  end

  context 'when logged out' do
    it 'cannot vote' do
      page.open
      expect {
        page.like('Empire strikes back')
      }.to raise_error(Capybara::ElementNotFound)
    end
  end

  context 'when logged in' do
    with_logged_in_user

    before { page.open }

    context 'can like' do
      it 'displays a vote message' do
        page.like('Empire strikes back')
        expect(page).to have_vote_message
      end

      it 'notifies the movie author' do
        Sidekiq::Testing.inline!
        expect{ page.like('Empire strikes back') }.to change{ ActionMailer::Base.deliveries.size }.by(1)
        notification_email = ActionMailer::Base.deliveries.last

        expect(notification_email.subject).to eq("Find out who likes your movie")
        expect(notification_email.to[0]).to eq(author.email)
      end
    end

    context 'can hate' do
      it 'displays a vote message' do
        page.hate('Empire strikes back')
        expect(page).to have_vote_message
      end

      it 'notifies the movie author' do
        Sidekiq::Testing.inline!
        expect{ page.hate('Empire strikes back') }.to change{ ActionMailer::Base.deliveries.size }.by(1)
        notification_email = ActionMailer::Base.deliveries.last

        expect(notification_email.subject).to eq("Find out who hates your movie")
        expect(notification_email.to[0]).to eq(author.email)
      end
    end

    it 'can unlike' do
      page.like('Empire strikes back')
      page.unlike('Empire strikes back')
      expect(page).to have_unvote_message
    end

    it 'can unhate' do
      page.hate('Empire strikes back')
      page.unhate('Empire strikes back')
      expect(page).to have_unvote_message
    end

    it 'cannot like twice' do
      expect {
        2.times { page.like('Empire strikes back') }
      }.to raise_error(Capybara::ElementNotFound)
    end

    it 'cannot like own movies' do
      Pages::MovieNew.new.open.submit(
        title:       'The Party',
        date:        '1969-08-13',
        description: 'Birdy nom nom')
      page.open
      expect {
        page.like('The Party')
      }.to raise_error(Capybara::ElementNotFound)
    end
  end

end



