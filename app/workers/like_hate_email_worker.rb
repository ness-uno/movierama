class LikeHateEmailWorker
  include Sidekiq::Worker

  def perform(json_params)
    params = LikeHateEmailParams.from_json(json_params)
    UserMailer.like_hate_email(params).deliver
  end

end
