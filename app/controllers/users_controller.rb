class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @user = current_user
    render(layout: "layouts/guide")
  end

  def friends_signup
    render(layout: "application")
  end

  def reward_like
    unless current_user.likes_me
      current_user.likeify
    end
    respond_to do |format|
      format.html { redirect_to session[:previous_url]}
    end
  end

  def index
    redirect_to "/"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id)
    end
end