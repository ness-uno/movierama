class PreferenceEmailWorker
  include Sidekiq::Worker

  def perform(json_params)
    # The Sidekiq client API uses JSON.dump to send the data to Redis.
    # The Sidekiq server pulls that JSON data from Redis and uses JSON.load
    # to convert the data back into Ruby types to pass to your perform method.

    params = PreferenceEmailParams.from_json(json_params)
    UserMailer.preference_email(params).deliver
  end

end
