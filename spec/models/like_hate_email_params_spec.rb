require 'rails_helper'

RSpec.describe LikeHateEmailParams do
  describe '.build' do
    let(:movie) { double('Movie', user: author, title: 'Matrix') }
    let(:author) { double('User', email: 'author@example.com', name: 'Luigi') }
    let(:user) { double('User', name: 'Mario') }
    let(:action) { :like }

    subject { described_class.build(user: user, movie: movie, action: action) }

    it 'returns a LikeHateEmailParams' do
      expect(subject).to be_a(LikeHateEmailParams)
    end

    it 'sets properties based on the input' do
      expect(subject.recipient_email).to eq(author.email)
      expect(subject.recipient_name).to eq(author.name)
      expect(subject.user_name).to eq(user.name)
      expect(subject.movie_title).to eq(movie.title)
      expect(subject.action).to eq(action)
    end
  end

  describe '.from_json' do
    let(:json_string) { "{\"recipient_email\":\"author@example.com\",\"recipient_name\":\"Luigi\",\"user_name\":\"Mario\",\"movie_title\":\"Matrix\",\"action\":\"like\"}" }
    let(:json) { JSON.parse(json_string) }
    subject { described_class.from_json(json) }

    it 'returns a LikeHateEmailParams' do
      expect(subject).to be_a(LikeHateEmailParams)
    end

    it 'sets properties based on the input' do
      expect(subject.recipient_email).to eq('author@example.com')
      expect(subject.recipient_name).to eq('Luigi')
      expect(subject.user_name).to eq('Mario')
      expect(subject.movie_title).to eq('Matrix')
      expect(subject.action).to eq(:like)
    end

    describe '#to_json' do
      let(:recipient_email) { 'author@example.com' }
      let(:recipient_name) { 'Luigi' }
      let(:user_name) { 'Mario' }
      let(:movie_title) { 'Matrix' }
      let(:action) { :like }

      let(:params) { described_class.new(recipient_email, recipient_name, user_name, movie_title, action) }

      subject { JSON.parse(params.to_json) }

      it 'serialises the object' do
        expect(subject['recipient_email']).to eq('author@example.com')
        expect(subject['recipient_name']).to eq('Luigi')
        expect(subject['user_name']).to eq('Mario')
        expect(subject['movie_title']).to eq('Matrix')
        expect(subject['action']).to eq('like')
      end
    end
  end
end
