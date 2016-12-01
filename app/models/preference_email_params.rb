class PreferenceEmailParams < Struct.new(:recipient_email, :recipient_name, :user_name, :movie_title, :preference)
  class << self
    def build(user:, movie:, preference:)
      new.tap do |email_params|
        recipient = movie.user
        email_params.recipient_email = recipient.email
        email_params.recipient_name = recipient.name
        email_params.user_name = user.name
        email_params.movie_title = movie.title
        email_params.preference = preference
      end
    end

    def from_json(json)
      new.tap do |email_params|
        email_params.recipient_email = json['recipient_email']
        email_params.recipient_name = json['recipient_name']
        email_params.user_name = json['user_name']
        email_params.movie_title = json['movie_title']
        vote = json['preference'].to_sym
        email_params.preference = Preference.for(vote)
      end
    end
  end

  def to_json(*options)
    {
      recipient_email: recipient_email,
      recipient_name: recipient_name,
      user_name: user_name,
      movie_title: movie_title,
      preference: preference.vote,
    }.to_json
  end
end
