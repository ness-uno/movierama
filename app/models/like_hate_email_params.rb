class LikeHateEmailParams < Struct.new(:recipient_email, :recipient_name, :user_name, :movie_name, :action)
  class << self
    def build(user:, movie:, action:)
      new.tap do |email_params|
        recipient = movie.user
        email_params.recipient_email = recipient.email
        email_params.recipient_name = recipient.name
        email_params.user_name = user.name
        email_params.movie_name = movie.title
        email_params.action = action
      end
    end

    def from_json(json)
      new.tap do |email_params|
        email_params.recipient_email = json['recipient_email']
        email_params.recipient_name = json['recipient_name']
        email_params.user_name = json['user_name']
        email_params.movie_name = json['movie_name']
        email_params.action = json['action'].to_sym
      end
    end
  end

  def to_json(*options)
    {
      recipient_email: recipient_email,
      recipient_name: recipient_name,
      user_name: user_name,
      movie_name: movie_name,
      action: action,
    }.to_json
  end
end
