include ApplicationHelper

def simulate_sign_in
  let(:user) { FactoryGirl.create(:user) }
  find('#signinTrigger').click #click the modal
  find('.reveal-nonsocial-in-signin-modal').click #reveal nonsocial signin form
  # Fill out & submit form
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end