class Notifier
  def initialize(user:, movie:)
    @user = user
    @movie = movie
  end

  def notify(like_or_dislike)
    email_params = email_params(like_or_dislike)
    deliver_like_email(email_params)
  end

  private

  attr_reader :recipient, :user, :movie

  def email_params(like_or_dislike)
    LikeHateEmailParams.build(
      user: user,
      movie: movie,
      action: like_or_dislike
    )
  end

  def deliver_like_email(email_params)
    LikeHateEmailWorker.perform_async(email_params)
  end
end
