class LikeHateEmailWorker
  include Sidekiq::Worker

  def perform(email_params)
    UserMailer.like_hate_email(email_params).deliver
  end

end
