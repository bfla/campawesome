class SignupNotifier < ActionMailer::Base
  default from: "Brian at CampHero <brian@getcamphero.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.signup_notifier.welcome.subject
  #
  def welcome(user)
    @greeting = "Hi."
    @name = user.name unless user.name == nil || user.name = "Anonymous"

    mail to: user.email, subject: 'Hi & nice to meet you.'
  end
end
