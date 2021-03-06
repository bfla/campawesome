class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :store_location
  has_mobile_fu false

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/password" &&
        request.fullpath != "/users/sign_out" &&
        request.fullpath != "/users/" &&
        !(request.fullpath.include? "callback") &&
        !(request.fullpath.include? "json") &&
        request.fullpath != new_registration_path(:user) &&
        request.fullpath != new_session_path(:user) &&
        request.fullpath != photos_path &&
        request.fullpath != new_tribal_membership_path && #"/tribal_memberships/new"
        request.fullpath != tribal_memberships_path &&
        request.fullpath != contrib_campsites_path &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    else
      session[:previous_url] = home_path if session[:previous_url].blank?
    end
  end
  def store_token
    session['fb_access_token'] = auth['credentials']['token']
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || home_path
  end
  #def after_sign_up_path_for(resource)
    #session[:previous_url] = new_tribal_membership_path
    #session[:previous_url] || root_path
  #end
  def after_sign_out_path_for(resource)
    session[:previous_url] || home_path
  end

  def admin_only
    redirect_to forbidden_path unless current_user && current_user.is_admin
  end

end
