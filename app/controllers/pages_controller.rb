class PagesController < ApplicationController

  def home
    if user_signed_in?
      @user = User.includes(:tribe, :beens, :wants, :lists, :photos, :reviews).find(current_user)
      @friends = current_user.fb_friends
      gon.friends = current_user.fb_friends
    end
    if user_signed_in? && !current_user.tribe.blank?
      if !request.location.nil? && Rails.env.production?
        @state = State.find_by(name: request.location.state) || @user.state || nil
        location = request.location
      elsif user_signed_in?
        @state = @user.state unless @user.state.blank?
        location = @user.location unless @user.location.blank?
      end
      unless @state.blank?
        #Student.joins(:schools).where(schools: { category: 'public' })
        @recommendations = @state.campsites.first(4)
        @best_of_state = @state.destinations.first(4)
      end
      unless location.blank?
        @nearbys = Campsite.near(location, radius = 50).first(4)
      end
    end
    render layout:"layouts/pages/home"
  end

  def reasons # Reasons to sign up
  end

  def terms #Terms of use
  end

  def privacy #Privacy policy
  end

  def takedown # DMCA takedown policy
  end

end
