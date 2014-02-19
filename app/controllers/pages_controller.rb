class PagesController < ApplicationController

  def home
    if user_signed_in?
      @user = User.includes(:tribe, :beens, :wants, :lists, :photos, :reviews).find(current_user)
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
