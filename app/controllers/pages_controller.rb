class PagesController < ApplicationController

  def home
    if user_signed_in?
      @user = User.includes(:tribe, :beens, :wants, :lists, :photos, :reviews).find(current_user)
    end
    if false #request.location?
      geo_coded_state = request.location.state
      state = State.find_by_name(geo_coded_state)
      @recommendations = state.campsites.first(4) unless current_user.tribe.blank?
      @best_of_state = state.destinations.first(4)
      @nearbys = Campsite.near(request.location, radius = 50).first(4)
    elsif !@user.location.blank?
      state = State.find(@user.state_id)
      @recommendations = state.campsites.first(4) unless current_user.tribe.blank?
      @best_of_state = state.destinations.first(4)
      @nearbys = Campsite.near(@user.location, radius = 50).first(4)
    end
    render layout:"layouts/pages/home"
  end

  def terms #Terms of use
  end

  def privacy #Privacy policy
  end

  def takedown # DMCA takedown policy
  end

end
