class Notifier
  def initialize(user:, movie:)
    @user = user
    @movie = movie
  end

  def notify(like_or_hate)
    email_params = email_params(like_or_hate)
    deliver_like_email(email_params)
  end

  private

  attr_reader :recipient, :user, :movie

  def email_params(like_or_hate)
    LikeHateEmailParams.build(
      user: user,
      movie: movie,
      action: like_or_hate
    )
  end

  def deliver_like_email(email_params)
    LikeHateEmailWorker.perform_async(email_params)
  end
end
