class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    puts "Attempting FB login using find_for_facebook_oauth..."
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])
    puts "Found user with FB login..."
    if @user.persisted?
      puts "FB user persisted... Attempting sign_in_and_redirect..."
      #sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      sign_in @user, :event => :authentication #this will throw if @user is not activated
      if @user.sign_in_count == 1
        redirect_to new_tribal_membership_path
      else
        redirect_to session[:previous_url]
      end
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      puts "FB user did not persist..."
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      #redirect_to new_user_registration_url
      redirect_to new_user_registration_url
      puts "Redirected to new_user_registration_url"
    end
  end
end