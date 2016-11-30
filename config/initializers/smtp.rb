ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address        => 'smtp.gmail.com',
  :port           => 587,
  :domain         => 'movierama.dev',
  :authentication => :plain,
  :user_name      => ENV.fetch('SMTP_USER_NAME'),
  :password       => ENV.fetch('SMTP_PASSWORD')
}
