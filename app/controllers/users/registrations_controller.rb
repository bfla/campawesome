class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    puts "Running after_sign_up_path_for..."
    new_tribal_membership_path
  end
end