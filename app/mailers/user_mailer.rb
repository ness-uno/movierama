class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def like_hate_email(email_params)
    assert_valid_action!(email_params.action)
    @recipient_name = email_params.recipient_name
    @user_name = email_params.user_name
    @movie_name = email_params.movie_name

    mail(
      to: email_params.recipient_email,
      subject: "Find out who #{email_params.action.to_s.pluralize} your movie",
      template_name: "#{email_params.action}_email"
    )
  end

  private

  def assert_valid_action!(action)
    raise ArgumentError.new("`#{action}` is not a valid action") unless %i( like hate ).include?(action)
  end

end
