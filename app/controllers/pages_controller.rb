class PagesController < ApplicationController

  def home
    if user_signed_in?
      @user = User.includes(:tribe).find(current_user)
      @friends = current_user.fb_friends
      gon.friends = current_user.fb_friends
    
      if Rails.env.production?
        # Generate recommended campgrounds
        if !request.location.nil? # if request location is known, use it
          @state = State.find_by(name: request.location.state) || @user.state || nil
          location = request.location
          # set nearby campgrounds
          @nearbys = Campsite.near(location, radius = 50).first(4)
        elsif !@user.state.blank? # if request location isn't known, use user's state if available
          @state = @user.state
        end
      end

      # Generate state-level recommendations
      @state ||= State.find(1) # If unkown, Michigan is the default
      # Generate state-level campsite recommendations
      if !@user.tribe.blank?
        @recommendations = @state.campsites.first(4)
      end
      # Generate state-level destination recommendations...
      @best_of_state = @state.destinations.first(4)

    end # ...end of user_signed_in? test

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

  def forbidden #Forbidden action or url
  end

  def bloggers
  end

  def smallbiz
  end

  def advertisers
  end

end
