class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def preference_email(email_params)
    @recipient_name = email_params.recipient_name
    @user_name = email_params.user_name
    @movie_title = email_params.movie_title

    vote = email_params.preference.vote.to_s
    vote_for_subject = vote.pluralize

    mail(
      to: email_params.recipient_email,
      subject: "Find out who #{vote_for_subject} your movie",
      template_name: "#{vote}_email"
    )
  end

end
