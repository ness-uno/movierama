class Notifier
  def initialize(user:, movie:)
    @user = user
    @movie = movie
  end

  def notify(preference)
    email_params = email_params(preference)
    deliver_preference_email(email_params)
  end

  private

  attr_reader :recipient, :user, :movie

  def email_params(preference)
    PreferenceEmailParams.build(
      user: user,
      movie: movie,
      preference: preference
    )
  end

  def deliver_preference_email(email_params)
    PreferenceEmailWorker.perform_async(email_params)
  end
end
