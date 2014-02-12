class TribalMembershipsController < ApplicationController
  before_action :set_tribal_membership, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create]

  # GET /tribal_memberships
  # GET /tribal_memberships.json
  def index
    @tribal_memberships = TribalMembership.all
  end

  # GET /tribal_memberships/1
  # GET /tribal_memberships/1.json
  def show
  end

  # GET /tribal_memberships/new
  def new
    @tribal_membership = TribalMembership.new
    @tribes = Tribe.all
  end

  # GET /tribal_memberships/1/edit
  def edit
  end

  # POST /tribal_memberships
  # POST /tribal_memberships.json
  def create
    @tribes = Tribe.all
    if current_user.tribe.blank?
      @tribal_membership = TribalMembership.new(tribal_membership_params)
    else
      @tribal_membership = current_user.tribal_membership
      @tribal_membership.tribe_id = params[:tribe_id]
      @tribal_membership.save
    end

    respond_to do |format|
      if @tribal_membership.save
        format.html { redirect_to session[:previous_url], notice: 'Tribal membership was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tribal_membership }
      else
        format.html { redirect_to session[:previous_url] }
        format.json { render json: @tribal_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tribal_memberships/1
  # PATCH/PUT /tribal_memberships/1.json
  def update
    respond_to do |format|
      if @tribal_membership.update(tribal_membership_params)
        format.html { redirect_to @tribal_membership, notice: 'Tribal membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tribal_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tribal_memberships/1
  # DELETE /tribal_memberships/1.json
  def destroy
    @tribal_membership.destroy
    respond_to do |format|
      format.html { redirect_to tribal_memberships_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tribal_membership
      @tribal_membership = TribalMembership.find(params[:id])
    end
    def set_user
      params[:user_id] = current_user
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def tribal_membership_params
      params.require(:tribal_membership).permit(:tribe_id, :user_id)
    end
end
